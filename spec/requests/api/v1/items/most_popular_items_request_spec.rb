require 'rails_helper'

RSpec.describe 'Item Most Popular Items API' do
  context 'when the items exists' do
    it 'returns top x number of items' do
      num_results = 1
      item = create(:item, name: "Nimbus 3000")
      invoice = create(:invoice)
      Invoice_item = create(:invoice_item, invoice_id: invoice.id, quantity: 50, item_id: item.id)
      create(:transaction, invoice_id: invoice.id)
      5.times do
        create(:item)
      end

      get '/api/v1/items/most_items', params: {quantity: num_results}
      result = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(result.first["name"]).to eq("Nimbus 3000")
    end
  end
end
