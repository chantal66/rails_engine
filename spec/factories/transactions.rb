FactoryGirl.define do
  factory :transaction do
    credit_card_number "4242424242424242"
    result "success"
    invoice
    created_at "date"
    updated_at "date"
  end
end
