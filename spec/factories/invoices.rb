FactoryGirl.define do
  factory :invoice do
    status "MyString"
    merchant
    customer
    created_at Date.today
    updated_at Date.today
  end
end
