require 'rails_helper'

RSpec.describe "Merchants/Revenue API" do
  context "GET /api/v1/merchants/:id/revenue" do
    it "returns the total revenue for one merchants" do
      merchant = create(:merchant_with_items)
      invoice = create(:invoice, merchant_id: merchant.id, created_at: '2012-03-16 11:55:05', updated_at: '2012-03-16 11:55:05')
      invoice2 = create(:invoice, merchant_id: merchant.id, created_at: '2012-03-16 11:55:05', updated_at: '2012-03-16 11:55:05')
      InvoiceItem.create(invoice_id: invoice.id, item_id: merchant.items.first.id, quantity: 2, unit_price: 128934)
      InvoiceItem.create(invoice_id: invoice2.id, item_id: merchant.items.last.id, quantity: 3, unit_price: 823765)
      create(:transaction, invoice_id: invoice.id)
      create(:transaction, invoice_id: invoice2.id, result: 'success')

      get "/api/v1/merchants/#{merchant.id}/revenue?date=2012-03-16 11:55:05"

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(raw_merchant).to have_key("revenue")
      expect(raw_merchant["revenue"]).to be_a String
      expect(raw_merchant["revenue"]).to eq("27291.63")
    end
  end
end