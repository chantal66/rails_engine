require 'rails_helper'

RSpec.describe 'Transaction Find API' do
  context 'GET /api/v1/transactions/find?params' do
    it "returns transactions that matches specific id" do
      create_list(:transaction, 5)
      transaction = Transaction.first
      get "/api/v1/transactions/find?id=#{transaction.id}"


      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["invoice_id"]).to be_a Integer
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction["result"]).to be_a String
    end

    it "returns the first transaction it matches to a specific name" do
      create_list(:transaction, 5)
      transaction = Transaction.first

      get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["invoice_id"]).to be_a Integer
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction["result"]).to be_a String

    end

    it "returns the first transaction it matches to a result" do
      create_list(:transaction, 5)
      transaction = Transaction.first

      get "/api/v1/transactions/find?result=#{transaction.result}"

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["invoice_id"]).to be_a Integer
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction["result"]).to be_a String

    end

    it "returns the first transaction it matches to a invoice_id" do
      create_list(:transaction, 5)
      transaction = Transaction.first

      get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["invoice_id"]).to be_a Integer
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction["result"]).to be_a String

    end


    it 'returns the first transaction it matches by created_at date' do
      create_list(:transaction, 5, created_at: "2012-03-27 11:24:56")

      get '/api/v1/transactions/find?created_at=2012-03-27 11:24:56'

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["invoice_id"]).to be_a Integer
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction["result"]).to be_a String
    end

    it 'retunrns the first transaction it matches by updated_at date' do
      create_list(:transaction, 5, updated_at: "2012-03-27 11:24:56")

      get '/api/v1/transactions/find?updated_at=2012-03-27 11:24:56'

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["invoice_id"]).to be_a Integer
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction["result"]).to be_a String
    end
  end
end