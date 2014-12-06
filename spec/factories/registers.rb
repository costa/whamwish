FactoryGirl.define do

  factory :register do
    sequence(:key) {|n| "random-#{n}" }
  end

end
