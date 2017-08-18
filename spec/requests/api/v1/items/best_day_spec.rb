
require 'rails_helper'

RSpec.describe 'Item Best Day API' do
  context 'when the data exists' do
    it 'returns best day' do
      date = DateTime.new(2015,3,20)
      other_date = DateTime.new(2015,1,30)
      item = create(:item)
      invoice = create(:invoice, created_at: date)
      other_invoice = create(:invoice, created_at: other_date)
      another_invoice = create(:invoice, created_at: other_date)
      create(:transaction, invoice_id: invoice.id)
      create(:transaction, invoice_id: other_invoice.id)
      create(:invoice_item, quantity: 50, invoice_id: invoice.id, item_id: item.id)
      create(:invoice_item, quantity: 49, invoice_id: another_invoice.id, item_id: item.id)
      create(:invoice_item, quantity: 50, invoice_id: other_invoice.id, item_id: item.id)

      get "/api/v1/items/#{item.id}/best_day"
      result = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(result["best_day"]).to eq("2015-03-20T00:00:00.000Z")
    end
  end
end
