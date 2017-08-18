require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "associations" do
    it { is_expected.to respond_to(:merchant) }
    it { is_expected.to respond_to(:customer) }
  end
  describe "validations" do
    it { should validate_presence_of(:merchant_id) }
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
    it { should validate_presence_of(:status) }
  end
end
