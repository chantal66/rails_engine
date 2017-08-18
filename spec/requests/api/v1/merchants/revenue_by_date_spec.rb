require 'rails_helper'

describe 'Merchants Revenue API' do
  context 'GET /api/v1/merchants/:id/revenue?date=x' do
    it 'returns the total revenue for that merchant for a specific invoice date x' do
      date = "2012-03-16 11:55:05"
      merchant = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id, created_at: date)
      create(:transaction, invoice_id: invoice.id)
      create(:invoice_item, invoice_id: invoice.id, unit_price: 1025, quantity: 10)

      get "/api/v1/merchants/#{merchant.id}/revenue?date=#{date}"

      revenue = JSON.parse(response.body)

      expect(revenue["revenue"]).to eq("102.5")
    end
  end
end
