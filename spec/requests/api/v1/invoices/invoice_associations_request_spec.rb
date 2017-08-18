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
      create_list(:invoice_item, 4, invoice_id: invoice.id)

      get "/api/v1/invoices/#{invoice.id}/invoice_items"

      expect(response).to be_success

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(4)
      expect(transactions.first).to have_key('invoice_id')
      expect(transactions.first).to have_key('item_id')
      expect(transactions.first).to have_key('unit_price')
      expect(transactions.first).to have_key('quantity')
      expect(transactions.first['invoice_id']).to eq(invoice.id)
    end
  end

  context "GET /api/v1/invoices/:id/items" do
    it "returns a collection of associated items" do
      invoice = create(:invoice)
      item1, item2, item3 = create_list(:item, 3)
      invoice.items.append(item1, item2, item3)
      get "/api/v1/invoices/#{invoice.id}/items"

      expect(response).to be_success

      items = JSON.parse(response.body)
      item = items.first

      expect(items.count).to eq(3)
      expect(item).to have_key("name")
      expect(item).to have_key("description")
      expect(item).to have_key("unit_price")
      expect(item).to have_key("merchant_id")
    end
  end

  context "GET /api/v1/invoices/:id/customer" do
    it "returns the customer associated w invoice" do
      customer = create(:customer)
      invoice_1 = create(:invoice, customer_id: customer.id)

      get "/api/v1/invoices/#{invoice_1.id}/customer"

      expect(response).to be_success

      customer = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(customer).to have_key("first_name")
      expect(customer).to have_key("last_name")
    end
  end

  context "GET /api/v1/invoices/:id/merchant" do
    it "returns the associated merchant" do
      merchant = create(:merchant)
      invoice_1 = create(:invoice, merchant_id: merchant.id)

      get "/api/v1/invoices/#{invoice_1.id}/merchant"

      expect(response).to be_success

      merchant = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(merchant).to have_key("name")
    end
  end

end