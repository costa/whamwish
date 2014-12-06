describe Register do

  subject { FactoryGirl.create(:register) }

  it "#key returns a string" do
    expect(subject.key).to match //
  end

end
