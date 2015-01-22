FactoryGirl.define do

  factory :register do
    sequence(:key) {|n| "a-very-random-number-#{n}" }
  end

end
