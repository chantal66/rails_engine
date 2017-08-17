require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "associations" do
    it { is_expected.to respond_to(:invoice) }
    it { is_expected.to respond_to(:item) }
  end
  describe "validations" do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:item_id) }
    it { should validate_presence_of(:invoice_id) }
  end
end
