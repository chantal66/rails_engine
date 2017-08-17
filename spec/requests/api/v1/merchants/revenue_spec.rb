require 'rails_helper'

RSpec.describe "Merchants/Revenue API" do
  context "GET /api/v1/merchants/:id/revenue" do
    it 'returns total revenue for that merchant across transactions' do
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
      create(:transaction, invoice_id: invoice.id)
      create(:invoice_item, invoice_id: invoice.id, unit_price: 1111, quantity: 4)

      get "/api/v1/merchants/#{merchant.id}/revenue"

      raw_revenue = JSON.parse(response.body)
binding.pry
      expect(raw_revenue["revenue"]).to be_a String
      expect(raw_revenue["revenue"]).to eq("44.44")
    end
  end
end
