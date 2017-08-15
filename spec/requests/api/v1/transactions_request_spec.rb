require 'rails_helper'

describe "Transactions API" do
  context 'GET /api/v1/transactions' do
    it "sends a All transactions" do
      create_list(:transaction, 4)

      get '/api/v1/transactions'

      expect(response).to be_success
      raw_transactions = JSON.parse(response.body)
      raw_transaction = raw_transactions.first

      expect(raw_transactions.count).to eq(4)


    end
  end

  context 'GET /api/v1/merchants/:id' do
    xit 'sends one merchant' do
      merchant = create(:merchant)

      get "/api/v1/merchants/#{merchant.id}"

      expect(response).to be_success

      raw_merchant = JSON.parse(response.body)

      expect(raw_merchant["id"]).to eq(merchant.id)
      expect(raw_merchant).to have_key("name")
      expect(raw_merchant["name"]).to be_a String
    end
  end

end