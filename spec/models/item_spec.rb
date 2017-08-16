require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "Validations" do

    it "is created with attributes" do
      merchant = create(:merchant)
      item = create(:item, name: "Item", description: "description", merchant_id: merchant.id)

      expect(item).to be_valid
    end

  describe "Associations" do
    it "belongs to a merchant" do
      item = create(:item)

      expect(item).to respond_to(:merchant)
    end
  end
end
end
