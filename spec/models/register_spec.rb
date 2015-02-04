describe Register do

  subject { FactoryGirl.build(:register, key: 'dummydummydummydummy', title: 'dummy list') }

  before do
    expect(subject).to be_valid
  end

  describe '#key' do

    it "returns the string" do
      expect(subject.key).to eq 'dummydummydummydummy'
    end

    it "validates the length" do
      expect(subject.tap() {|register| register.key = 'tooshort'}).not_to be_valid
    end

  end

  %w[title subtitle].each do |tit|
    describe "##{tit}" do

      it "validates the length" do
        expect(subject.tap() {|register| register[tit] = 'toolong' * 100}).not_to be_valid
      end

    end
  end

  describe '#firebase_path' do

    it "returns the string" do
      expect(subject.firebase_path).to match /registers\/dummydummydummydummy$/
    end

  end

  describe '#as_json' do

    it "formats for json" do
      expect(subject.as_json).to eq HashWithIndifferentAccess.new(
        key: 'dummydummydummydummy',
        title: 'dummy list',
        subtitle: nil,
        bg_color: nil,
        created_at: nil,
        updated_at: nil
      )
    end

  end

  it "updates the firebase on create" do
    firebase_mock = double
    allow(Firebase::Client).to receive(:new).and_return firebase_mock
    expect(firebase_mock).to receive(:set) do |path, val|
      expect(path).to eq subject.firebase_path
      expect(val).to eq subject.as_json
      double :success? => true
    end
    subject.save!
  end

  it "doesn't save when firebase is throwing errors" do
    allow(Firebase::Client).to receive(:new).and_return double(:set => double(:success? => false))
    expect {
      subject.save!
    }.to raise_error
  end

end
