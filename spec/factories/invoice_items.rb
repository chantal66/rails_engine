FactoryGirl.define do
  factory :invoice_item do
    unit_price 10
    quantity 10
    invoice
    item
  end
end
