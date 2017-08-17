FactoryGirl.define do
  factory :invoice_item do
    quantity 3
    unit_price 4254434
    invoice
    item
  end
end
