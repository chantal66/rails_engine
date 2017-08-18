require 'rails_helper'

RSpec.describe 'items sold by merchant', type: :request do
  context 'merchant exists' do
    it 'returns total revenue' do
      merchant = create(:merchant, name: "Ankhesenamun")
      invoice = create(:invoice, merchant_id: merchant.id)
      create(:transaction, invoice_id: invoice.id)
      create(:invoice_item, quantity: 50, invoice_id: invoice.id)

      5.times do
        create(:merchant)
      end

      get "/api/v1/merchants/most_items", params: {quantity: 1}
      result = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(result.first["name"]).to eq("Ankhesenamun")
    end
  end
end

