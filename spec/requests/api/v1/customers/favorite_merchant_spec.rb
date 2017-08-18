require 'rails_helper'

RSpec.describe "Customers/FavoriteMerchant API" do
  context "GET /api/v1/customers/:id/favorite_merchant" do
    it "returns the favorite merchant for a customer" do
      merchant = create(:merchant_with_items)
      customer = create(:customer)
      customer2 = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: '2012-03-16 11:55:05', updated_at: '2012-03-16 11:55:05')
      invoice2 = create(:invoice, merchant_id: merchant.id, customer_id: customer2.id, created_at: '2012-03-16 11:55:05', updated_at: '2012-03-16 11:55:05')
      InvoiceItem.create(invoice_id: invoice.id, item_id: merchant.items.first.id, quantity: 2, unit_price: 128934)
      InvoiceItem.create(invoice_id: invoice2.id, item_id: merchant.items.last.id, quantity: 3, unit_price: 823765)
      create(:transaction, invoice_id: invoice.id)
      create(:transaction, invoice_id: invoice2.id, result: 'success')

      get "/api/v1/customers/#{customer2.id}/favorite_merchant"


      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(raw_merchant.first).to have_key("id")
      expect(raw_merchant.first).to have_key("name")
      expect(raw_merchant.first["id"]).to be_an Integer
      expect(raw_merchant.first["name"]).to be_an String
    end
  end
end