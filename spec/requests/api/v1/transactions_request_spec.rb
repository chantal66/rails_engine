require 'rails_helper'

describe "Transactions API" do
  context 'GET /api/v1/transactions' do
    it "sends a All transactions" do
      create_list(:transaction, 4)

      get '/api/v1/transactions'

      expect(response).to be_success
      raw_transactions = JSON.parse(response.body)
      raw_transaction = raw_transactions.first

      expect(response).to have_http_status(200)
      expect(raw_transactions.count).to eq(4)
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["result"]).to be_a String
      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction["invoice_id"]).to be_a Integer
    end
  end

  context 'GET /api/v1/transactions/:id' do
    it 'sends one transaction' do
      transaction = create(:transaction)

      get "/api/v1/transactions/#{transaction.id}"

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(raw_transaction["id"]).to eq(transaction.id)
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["result"]).to be_a String
      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction["invoice_id"]).to be_a Integer


    end
  end

end