FactoryGirl.define do
  factory :transaction do
    credit_card_number "4242424242424242"
    credit_card_expiration_date "2017-08-15"
    result 1

    # invoice
  end
end
