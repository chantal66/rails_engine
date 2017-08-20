require 'rails_helper'

RSpec.describe "Merchants/MostRevenue API" do
  context "GET /api/v1/merchants/most_revenue?quantity=x" do
    xit "returns top x merchants ranked by total revenue" do
      merchant = create(:merchant_with_items)
      invoice = create(:invoice, merchant_id: merchant.id)
      invoice2 = create(:invoice, merchant_id: merchant.id)
      InvoiceItem.create(invoice_id: invoice.id, item_id: merchant.items.first.id, quantity: 2, unit_price: 128934)
      InvoiceItem.create(invoice_id: invoice2.id, item_id: merchant.items.last.id, quantity: 3, unit_price: 823765)
      create(:transaction, invoice_id: invoice.id)
      create(:transaction, invoice_id: invoice2.id, result: 'success')

      get "/api/v1/merchants/most_revenue?quantity=1"

      expect(response).to be_success

      raw_data = JSON.parse(response.body)
      raw_merchant = raw_data.first

      expect(raw_merchant).to have_key("id")
      expect(raw_merchant).to have_key("name")
      expect(raw_merchant["id"]).to be_a Integer
      expect(raw_merchant["name"]).to be_a String
      expect(raw_merchant["id"]).to eq(invoice.merchant.id)
      expect(raw_merchant["name"]).to eq(invoice.merchant.name)
    end
  end
end