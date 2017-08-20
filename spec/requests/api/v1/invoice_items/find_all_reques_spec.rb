require 'rails_helper'

RSpec.describe "InvoiceItem/FindAll API" do
  context "GET /api/v1/invoice_items/find_all?params" do
    it "returns all invoice_items that match a specific id" do
      create_list(:invoice_item, 4)
      invoice_item = InvoiceItem.first

      get "/api/v1/invoice_items/find_all?id=#{invoice_item.id}"

      expect(response).to be_success

      raw_invoice_items = JSON.parse(response.body)
      raw_invoice_item = raw_invoice_items.first

      expect(raw_invoice_items.count).to eq(1)
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

    it "returns all invoice_items that match a specific quantity" do
      create_list(:invoice_item, 3)
      invoice_item = InvoiceItem.first
      invoice_item_3 = InvoiceItem.last
      invoice_item_4 = create(:invoice_item, quantity: 100)

      get "/api/v1/invoice_items/find_all?quantity=#{invoice_item.quantity}"

      expect(response).to be_success

      raw_invoice_items = JSON.parse(response.body)
      raw_invoice_item = raw_invoice_items.first
      raw_invoice_item_3 = raw_invoice_items.last

      expect(raw_invoice_items.count).to eq(3)
      expect(raw_invoice_item["id"]).to eq(invoice_item.id)
      expect(raw_invoice_item_3["id"]).to_not eq(invoice_item_4.id)
      expect(raw_invoice_item_3["id"]).to eq(invoice_item_3.id)
      expect(raw_invoice_item["quantity"]).to eq(invoice_item.quantity)
    end

    it "returns all invoice_items that match a specific unit_price" do
      create_list(:invoice_item, 3, unit_price: 55890)
      invoice_item = InvoiceItem.first
      invoice_item_3 = InvoiceItem.last
      invoice_item_4 = create(:invoice_item, unit_price: 100)

      get "/api/v1/invoice_items/find_all?unit_price=558.9"

      expect(response).to be_success

      raw_invoice_items = JSON.parse(response.body)
      raw_invoice_item = raw_invoice_items.first
      raw_invoice_item_3 = raw_invoice_items.last

      expect(raw_invoice_items.count).to eq(3)
      expect(raw_invoice_item["id"]).to eq(invoice_item.id)
      expect(raw_invoice_item_3["id"]).to_not eq(invoice_item_4.id)
      expect(raw_invoice_item_3["id"]).to eq(invoice_item_3.id)
      expect(raw_invoice_item["unit_price"]).to eq("558.9")
    end

    it "returns all invoice_items that match a specific invoice id" do
      create_list(:invoice_item, 3)
      invoice_item = InvoiceItem.first
      invoice_item_3 = InvoiceItem.last
      invoice_item_4 = create(:invoice_item, invoice_id: invoice_item.invoice_id)

      get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_item.invoice_id}"

      expect(response).to be_success

      raw_invoice_items = JSON.parse(response.body)
      raw_invoice_item = raw_invoice_items.first
      raw_invoice_item_3 = raw_invoice_items.last

      expect(raw_invoice_items.count).to eq(2)
      expect(raw_invoice_item["id"]).to eq(invoice_item.id)
      expect(raw_invoice_item_3["id"]).to_not eq(invoice_item_3.id)
      expect(raw_invoice_item_3["id"]).to eq(invoice_item_4.id)
      expect(raw_invoice_item["invoice_id"]).to eq(invoice_item.invoice_id)
    end

    it "returns all invoice_items that match a specific item id" do
      create_list(:invoice_item, 3)
      invoice_item = InvoiceItem.first
      invoice_item_3 = InvoiceItem.last
      invoice_item_4 = create(:invoice_item, item_id: invoice_item.item_id)

      get "/api/v1/invoice_items/find_all?item_id=#{invoice_item.item_id}"

      expect(response).to be_success

      raw_invoice_items = JSON.parse(response.body)
      raw_invoice_item = raw_invoice_items.first
      raw_invoice_item_3 = raw_invoice_items.last

      expect(raw_invoice_items.count).to eq(2)
      expect(raw_invoice_item["id"]).to eq(invoice_item.id)
      expect(raw_invoice_item_3["id"]).to_not eq(invoice_item_3.id)
      expect(raw_invoice_item_3["id"]).to eq(invoice_item_4.id)
      expect(raw_invoice_item["item_id"]).to eq(invoice_item.item_id)
    end

    it "returns all invoice_items that match a specific created_at" do
      create_list(:invoice_item, 3, created_at: "2012-03-04 22:53:51")
      invoice_item = InvoiceItem.first
      invoice_item_3 = InvoiceItem.last
      invoice_item_4 = create(:invoice_item)

      get "/api/v1/invoice_items/find_all?created_at=2012-03-04 22:53:51"

      expect(response).to be_success

      raw_invoice_items = JSON.parse(response.body)
      raw_invoice_item = raw_invoice_items.first
      raw_invoice_item_3 = raw_invoice_items.last

      expect(raw_invoice_items.count).to eq(3)
      expect(raw_invoice_item["id"]).to eq(invoice_item.id)
      expect(raw_invoice_item_3["id"]).to_not eq(invoice_item_4.id)
      expect(raw_invoice_item_3["id"]).to eq(invoice_item_3.id)
    end

    it "returns all invoice_items that match a specific updated_at" do
      create_list(:invoice_item, 3, updated_at: "2012-03-04 22:53:51")
      invoice_item = InvoiceItem.first
      invoice_item_3 = InvoiceItem.last
      invoice_item_4 = create(:invoice_item)

      get "/api/v1/invoice_items/find_all?updated_at=2012-03-04 22:53:51"

      expect(response).to be_success

      raw_invoice_items = JSON.parse(response.body)
      raw_invoice_item = raw_invoice_items.first
      raw_invoice_item_3 = raw_invoice_items.last

      expect(raw_invoice_items.count).to eq(3)
      expect(raw_invoice_item["id"]).to eq(invoice_item.id)
      expect(raw_invoice_item_3["id"]).to_not eq(invoice_item_4.id)
      expect(raw_invoice_item_3["id"]).to eq(invoice_item_3.id)
    end
  end
end
