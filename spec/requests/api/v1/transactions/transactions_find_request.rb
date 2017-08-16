require 'rails_helper'

RSpec.describe 'Transaction Find API' do
  context 'GET /api/v1/transactions/find?params' do
    it "returns transactions that matches specific id" do
      create_list(:transaction, 5)
      transaction = Transaction.first
      get "/api/v1/transactions/find?id=#{transaction.id}"


      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(raw_transaction).to have_key("id")
      expect(raw_transaction).to have_key("name")
      expect(raw_transaction["id"]).to be_a Integer
      expect(raw_transaction["name"]).to be_a String
    end

    xit "returns the first transaction it matches to a specific name" do
      create_list(:transaction, 5)
      transaction = Transaction.first

      get "/api/v1/transactions/find?name=#{transaction.name}"

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(raw_transaction["id"]).to eq(transaction.id)
      expect(raw_transaction["name"]).to eq(transaction.name)
    end

    xit 'retunrns the first transaction it matches by created_at date' do
      create_list(:transaction, 5, created_at: "2012-03-27 11:24:56")
      transaction = Transaction.first

      get '/api/v1/transactions/find?created_at=2012-03-27 11:24:56'

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(raw_transaction['id']).to eq(transaction.id)
      expect(raw_transaction['name']).to eq(transaction.name)
    end

    xit 'retunrns the first transaction it matches by updated_at date' do
      create_list(:transaction, 5, created_at: "2012-03-27 11:24:56")
      transaction = Transaction.first

      get '/api/v1/transactions/find?updated_at=2012-03-27 11:24:56'

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(raw_transaction['id']).to eq(transaction.id)
      expect(raw_transaction['name']).to eq(transaction.name)
    end
  end
end