FactoryGirl.define do
  factory :item do
    name "ItemName"
    description "ItemDescription"
    unit_price 97532
    association :merchant, factory: :merchant
  end
end
