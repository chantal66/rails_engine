require 'rails_helper'
RSpec.describe "Merchants/Favorite Customer API" do
  context "GET /api/v1/merchants/:id/favorite_customer" do
    it "returns the customer who has conducted the most total number of successful transactions" do
      merchant = create(:merchant_with_items)
      invoice = create(:invoice, merchant_id: merchant.id)
      invoice2 = create(:invoice, merchant_id: merchant.id)
      InvoiceItem.create(invoice_id: invoice.id, item_id: merchant.items.first.id, quantity: 2, unit_price: 128934)
      InvoiceItem.create(invoice_id: invoice2.id, item_id: merchant.items.last.id, quantity: 3, unit_price: 823765)
      create(:transaction, invoice_id: invoice.id)
      create(:transaction, invoice_id: invoice2.id, result: 'success')
      get "/api/v1/merchants/#{merchant.id}/favorite_customer"
      expect(response).to be_success
      raw_customer = JSON.parse(response.body)

      expect(raw_customer).to have_key("id")
      expect(raw_customer["id"]).to be_a Integer
    end
  end
end
