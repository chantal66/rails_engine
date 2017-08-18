require 'rails_helper'

describe 'Random customer API' do
  context 'GET /api/v1/customers/random' do
    it 'sends a random customer' do
      create_list(:customer, 5)

      get '/api/v1/customers/random'

      expect(response).to be_success

      raw_data = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(raw_data).to have_key("id")
    end
  end
end
