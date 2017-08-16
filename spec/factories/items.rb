FactoryGirl.define do
  factory :item do
    name "ItemName"
    description "ItemDescription"
    unit_price "ItemUnitPrice"
    merchant
  end
end
