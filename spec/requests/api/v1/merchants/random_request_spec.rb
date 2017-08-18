require 'rails_helper'

describe 'Random Merchant API' do
  context 'GET /api/v1/merchants/random' do
    it 'sends a random merchant' do
      create_list(:merchant, 5)
      get '/api/v1/merchants/random'

      expect(response).to be_success

      expect(response).to have_http_status(200)
      raw_merchant = JSON.parse(response.body)
      expect(raw_merchant).to have_key("id")
    end
  end
end