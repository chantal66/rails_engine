require 'rails_helper'

describe 'Invoice Relationship endpoints' do
  context 'GET /api/v1/invoices/:id:transactions' do
    it 'returns a collection of invoices associated with transactions' do
      invoice = create(:invoice)
      create_list(:transaction, 4, invoice_id: invoice.id)

      get "/api/v1/invoices/#{invoice.id}/transactions"

      expect(response).to be_success

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(4)
      expect(transactions.first).to have_key('invoice_id')
      expect(transactions.first).to have_key('credit_card_number')
      expect(transactions.first).to have_key('result')
      expect(transactions.first['invoice_id']).to eq(invoice.id)
      expect(transactions.first['credit_card_number']).to be_a String
    end
  end

  context 'GET /api/v1/invoices/:id:invoice_items' do
    it 'returns a collection of invoices associated with invoice items' do
      invoice = create(:invoice)
      create_list(:invoice_items, 4, invoice_id: invoice.id)

      get "/api/v1/invoices/#{invoice.id}/invoice_items"

      expect(response).to be_success

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(4)
      binding.pry
      expect(transactions.first).to have_key('invoice_id')
      expect(transactions.first).to have_key('credit_card_number')
      expect(transactions.first).to have_key('result')
      expect(transactions.first['invoice_id']).to eq(invoice.id)
      expect(transactions.first['credit_card_number']).to be_a String
    end
  end
end