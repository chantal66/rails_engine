require 'rails_helper'

RSpec.describe 'Merchant Find ALL API' do
  context 'GET /api/v1/merchants/find_all?params' do
    it "returns all merchants that matches specific id" do
      create_list(:merchant, 5)
      merchant = Merchant.first

      get "/api/v1/merchants/find_all?id=#{merchant.id}"


      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(raw_merchant.first["id"]).to eq(merchant.id)
      expect(raw_merchant.first["name"]).to eq(merchant.name)
    end

    it "returns all merchants that matches a specific name" do
      create_list(:merchant, 5)
      merchant = Merchant.first

      get "/api/v1/merchants/find_all?name=#{merchant.name}"

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(raw_merchant.first["id"]).to eq(merchant.id)
      expect(raw_merchant.first["name"]).to eq(merchant.name)
    end

    it 'returns all the first merchant it matches by create_at date' do
      create_list(:merchant, 5, created_at: "2012-03-27 11:24:56")
      merchant = Merchant.first

      get '/api/v1/merchants/find?created_at=2012-03-27 11:24:56'

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(raw_merchant['id']).to eq(merchant.id)
      expect(raw_merchant['name']).to eq(merchant.name)
    end

    it 'returns all the first merchant it matches by update_at date' do
      create_list(:merchant, 5, created_at: "2012-03-27 11:24:56")
      merchant = Merchant.first

      get '/api/v1/merchants/find?updated_at=2012-03-27 11:24:56'

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(raw_merchant['id']).to eq(merchant.id)
      expect(raw_merchant['name']).to eq(merchant.name)
    end
  end
end