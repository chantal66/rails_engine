require 'rails_helper'

RSpec.describe "Transaction Find All API" do
  context "GET /api/v1/transactions/find_all?params" do
    it "returns all transactions it matches to a specific id" do
      create_list(:transaction, 4)
      transaction = Transaction.first

      get "/api/v1/transactions/find_all?id=#{transaction.id}"

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body).first

      expect(response).to have_http_status(200)
      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["invoice_id"]).to be_a Integer
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction["result"]).to be_a String
    end

    it "returns all transactions it matches to a credit card number" do
      create_list(:transaction, 4)
      transaction = Transaction.first

      get "/api/v1/transactions/find_all?credit_card_number=#{transaction.credit_card_number}"

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body).first

      expect(response).to have_http_status(200)
      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["invoice_id"]).to be_a Integer
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction["result"]).to be_a String
    end

    it "returns all transactions it matches to a result" do
      create_list(:transaction, 4)
      transaction = Transaction.first

      get "/api/v1/transactions/find_all?result=#{transaction.result}"

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body).first

      expect(response).to have_http_status(200)
      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["invoice_id"]).to be_a Integer
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction["result"]).to be_a String
    end

    it "returns all transactions it matches to an invoice id" do
      create_list(:transaction, 4)
      transaction = Transaction.first

      get "/api/v1/transactions/find_all?invoice_id=#{transaction.invoice_id}"

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body).first

      expect(response).to have_http_status(200)
      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["invoice_id"]).to be_a Integer
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction["result"]).to be_a String
    end

    it "returns all transactions it matches by created at date" do
      create_list(:transaction, 4, created_at: "2012-03-27 11:24:56")

      get "/api/v1/transactions/find_all?created_at=2012-03-27 11:24:56"

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body).first

      expect(response).to have_http_status(200)
      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["invoice_id"]).to be_a Integer
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction["result"]).to be_a String
    end

    it "returns all transactions it matches by updated at date" do
      create_list(:transaction, 4, updated_at: "2012-03-27 11:24:56")

      get "/api/v1/transactions/find_all?updated_at=2012-03-27 11:24:56"

      expect(response).to be_success

      raw_transaction = JSON.parse(response.body).first

      expect(raw_transaction).to have_key("invoice_id")
      expect(raw_transaction).to have_key("credit_card_number")
      expect(raw_transaction).to have_key("result")
      expect(raw_transaction["invoice_id"]).to be_a Integer
      expect(raw_transaction["credit_card_number"]).to be_a String
      expect(raw_transaction["result"]).to be_a String
    end
  end
end
