require 'rails_helper'

describe 'Random transaction API' do
  context 'GET /api/v1/transactions/random' do
    it 'sends a random transaction' do
      create_list(:transaction, 5)
      get '/api/v1/transactions/random'

      expect(response).to be_success

      expect(response).to have_http_status(200)
      raw_merchant = JSON.parse(response.body)
      expect(raw_merchant).to have_key("id")
    end
  end
end