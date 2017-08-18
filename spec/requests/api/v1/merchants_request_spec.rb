require 'rails_helper'

describe "Merchants API" do
  context 'GET /api/v1/merchants' do
    it "sends a All merchants" do
      create_list(:merchant, 4)

      get '/api/v1/merchants'

      expect(response).to be_success
      merchants = JSON.parse(response.body)
      merchant = merchants.first

      expect(response).to have_http_status(200)
      expect(merchants.count).to eq(4)
      expect(merchant).to have_key("name")
      expect(merchant["name"]).to be_a String
    end
  end

  context 'GET /api/v1/merchants/:id' do
    it 'sends one merchant' do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}"

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(raw_merchant["id"]).to eq(merchant.id)
      expect(raw_merchant).to have_key("name")
      expect(raw_merchant["name"]).to be_a String
    end
  end

end