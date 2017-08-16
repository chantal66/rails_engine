FactoryGirl.define do
  factory :customer do
    sequence(:first_name) { |n| "Jane#{n}" }
    sequence(:last_name) { |n| "Doe#{n}" }
  end
end
