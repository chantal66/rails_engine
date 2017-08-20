require 'rails_helper'

RSpec.describe "InvoiceItem/Find API" do
  context "GET /api/v1/invoice_items/find?params" do
    it "returns the first invoice_item it matches to a specific id" do
      create_list(:invoice_item, 4)
      invoice_item = InvoiceItem.first

      get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

      expect(response).to be_success

      raw_invoice_item = JSON.parse(response.body)

      expect(raw_invoice_item.count).to eq(5)
      expect(raw_invoice_item).to have_key("id")
      expect(raw_invoice_item).to have_key("unit_price")
      expect(raw_invoice_item).to have_key("invoice_id")
      expect(raw_invoice_item).to have_key("quantity")
      expect(raw_invoice_item).to have_key("item_id")
      expect(raw_invoice_item["id"]).to be_a Integer
      expect(raw_invoice_item["invoice_id"]).to be_a Integer
      expect(raw_invoice_item["item_id"]).to be_a Integer
      expect(raw_invoice_item["quantity"]).to be_a Integer
      expect(raw_invoice_item["unit_price"]).to be_a String
    end

    it "returns the first invoice_item it matches to a specific quantity" do
      create_list(:invoice_item, 4)
      invoice_item = InvoiceItem.first

      get "/api/v1/invoice_items/find?quantity=#{invoice_item.quantity}"

      expect(response).to be_success

      raw_invoice_item = JSON.parse(response.body)

      expect(raw_invoice_item["id"]).to eq(invoice_item.id)
      expect(raw_invoice_item["quantity"]).to eq(invoice_item.quantity)
    end

    it "returns the first invoice_item it matches to a specific unit_price" do
      create_list(:invoice_item, 4, unit_price: 34568)
      invoice_item = InvoiceItem.first

      get "/api/v1/invoice_items/find?unit_price=345.68"

      expect(response).to be_success

      raw_invoice_item = JSON.parse(response.body)

      expect(raw_invoice_item["id"]).to eq(invoice_item.id)
      expect(raw_invoice_item["unit_price"]).to eq("345.68")
    end

    it "returns the first invoice_item it matches to a specific invoice id" do
      create_list(:invoice_item, 4)
      invoice_item = InvoiceItem.first

      get "/api/v1/invoice_items/find?invoice_id=#{invoice_item.invoice_id}"

      expect(response).to be_success

      raw_invoice_item = JSON.parse(response.body)

      expect(raw_invoice_item["id"]).to eq(invoice_item.id)
      expect(raw_invoice_item["invoice_id"]).to eq(invoice_item.invoice_id)
    end

    it "returns the first invoice_item it matches to a specific updated_at" do
      create_list(:invoice_item, 4)
      invoice_item = InvoiceItem.first

      get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"

      expect(response).to be_success

      raw_invoice_item = JSON.parse(response.body)

      expect(raw_invoice_item["id"]).to eq(invoice_item.id)
      expect(raw_invoice_item["item_id"]).to eq(invoice_item.item_id)
    end

    it "returns the first invoice_item it matches to a specific updated_at" do
      create_list(:invoice_item, 4)
      invoice_item = InvoiceItem.first

      get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"

      expect(response).to be_success

      raw_invoice_item = JSON.parse(response.body)

      expect(raw_invoice_item["id"]).to eq(invoice_item.id)
      expect(raw_invoice_item["item_id"]).to eq(invoice_item.item_id)
    end

    it "returns the first invoice_item it matches to a specific created_at" do
      create_list(:invoice_item, 4, created_at: "2012-03-04 22:53:51")
      invoice_item = InvoiceItem.first

      get "/api/v1/invoice_items/find?created_at=2012-03-04 22:53:51"

      expect(response).to be_success

      raw_invoice_item = JSON.parse(response.body)

      expect(raw_invoice_item["id"]).to eq(invoice_item.id)
    end

    it "returns the first invoice_item it matches to a specific updated_at" do
      create_list(:invoice_item, 4, updated_at: "2012-03-04 22:53:51")
      invoice_item = InvoiceItem.first

      get "/api/v1/invoice_items/find?updated_at=2012-03-04 22:53:51"

      expect(response).to be_success

      raw_invoice_item = JSON.parse(response.body)

      expect(raw_invoice_item["id"]).to eq(invoice_item.id)
    end
  end
end
