describe User do


  subject { FactoryGirl.build(:user) }

  it "#name returns a string" do
    expect(subject.name).to match //
  end

end
