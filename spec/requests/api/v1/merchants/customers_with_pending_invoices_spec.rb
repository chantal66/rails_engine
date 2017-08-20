require 'rails_helper'

RSpec.describe "Merchants/CustomerPending API" do
  context "GET /api/v1/merchants/:id/customers_with_pending_invoices" do
    xit "returns all customers which have pending (unpaid) invoices" do
      merchant = create(:merchant_with_items)
      invoice1 = create(:invoice, merchant_id: merchant.id)
      invoice2 = create(:invoice, merchant_id: merchant.id)
      InvoiceItem.create(invoice_id: invoice1.id, item_id: merchant.items.first.id, quantity: 2, unit_price: 128934)
      InvoiceItem.create(invoice_id: invoice2.id, item_id: merchant.items.last.id, quantity: 3, unit_price: 823765)
      create(:transaction, invoice_id: invoice1.id)
      create(:transaction, invoice_id: invoice2.id, result: 'success')

      get "/api/v1/merchants/#{merchant.id}/customers_with_pending_invoices"

      expect(response).to be_success

      raw_data = JSON.parse(response.body)
      raw_client = raw_data.first

      expect(raw_client).to have_key("id")
      expect(raw_client).to have_key("first_name")
      expect(raw_client).to have_key("last_name")
      expect(raw_client["id"]).to be_a Integer
      expect(raw_client["first_name"]).to be_a String
      expect(raw_client["last_name"]).to be_a String
    end
  end
end