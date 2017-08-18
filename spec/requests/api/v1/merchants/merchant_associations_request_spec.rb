require 'rails_helper'

describe 'Merchants Relationship Endpoints' do
  context 'GET /api/v1/merchants/:id/items' do
    it 'returns a collection of items associated with that merchant' do
      merchant = create(:merchant)
      create_list(:item, 4, merchant_id: merchant.id)

      get "/api/v1/merchants/#{merchant.id}/items"

      expect(response).to be_success

      items = JSON.parse(response.body)

      expect(items.count).to eq(4)
      expect(items.first).to have_key('name')
      expect(items.first).to have_key('description')
      expect(items.first).to have_key('unit_price')
      expect(items.first['name']).to be_a String
      expect(items.first['description']).to be_a String
    end
  end

  context 'GET /api/v1/merchants/:id/invoices' do
    it "returns a collection of invoices associated with the merchant's orders " do
      merchant = create(:merchant)
      create_list(:invoice, 5, merchant_id: merchant.id)

      get "/api/v1/merchants/#{merchant.id}/invoices"

      expect(response).to be_success

      invoices = JSON.parse(response.body)
      invoice = invoices.first

      expect(invoices.count).to eq(5)
      # binding.pry
      expect(invoice).to have_key("merchant_id")
      expect(invoice).to have_key("customer_id")
      expect(invoice).to have_key("status")
      expect(invoice["status"]).to be_a String
    end
  end
end
