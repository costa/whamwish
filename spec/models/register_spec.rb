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

end
