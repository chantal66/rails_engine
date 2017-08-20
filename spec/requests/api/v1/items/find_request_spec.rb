require 'rails_helper'

RSpec.describe "Item/Find API" do
  context "GET /api/v1/items/find?params" do
    it "returns the first item it matches to a specific id" do
      create_list(:item, 4)
      item = Item.first

      get "/api/v1/items/find?id=#{item.id}"

      expect(response).to be_success

      raw_item = JSON.parse(response.body)

      expect(raw_item.count).to eq(5)
      expect(raw_item).to have_key("id")
      expect(raw_item).to have_key("name")
      expect(raw_item).to have_key("description")
      expect(raw_item).to have_key("unit_price")
      expect(raw_item).to have_key("merchant_id")
      expect(raw_item["id"]).to be_a Integer
      expect(raw_item["name"]).to be_a String
      expect(raw_item["description"]).to be_a String
      expect(raw_item["unit_price"]).to be_a String
      expect(raw_item["merchant_id"]).to be_a Integer
    end

    it "returns the first item it matches to a specific name" do
      create_list(:item, 4)
      item = Item.first

      get "/api/v1/items/find?name=#{item.name}"

      expect(response).to be_success

      raw_item = JSON.parse(response.body)

      expect(raw_item["id"]).to eq(item.id)
      expect(raw_item["name"]).to eq(item.name)
    end

    it "returns the first item it matches to a specific unit_price" do
      create_list(:item, 4, unit_price: 34568)
      item = Item.first

      get "/api/v1/items/find?unit_price=345.68"

      expect(response).to be_success

      raw_item = JSON.parse(response.body)

      expect(raw_item["id"]).to eq(item.id)
      # binding.pry
      expect(raw_item["unit_price"]).to eq("345.68")
    end

    it "returns the first item it matches to a specific description" do
      create_list(:item, 4)
      item = Item.first

      get "/api/v1/items/find?invoice_id=#{item.description}"

      expect(response).to be_success

      raw_item = JSON.parse(response.body)

      expect(raw_item["id"]).to eq(item.id)
      expect(raw_item["description"]).to eq(item.description)
    end

    it "returns the first item it matches to a specific merchant_id" do
      create_list(:item, 4)
      item = Item.first

      get "/api/v1/items/find?item_id=#{item.merchant_id}"

      expect(response).to be_success

      raw_item = JSON.parse(response.body)

      expect(raw_item["id"]).to eq(item.id)
      expect(raw_item["merchant_id"]).to eq(item.merchant_id)
    end

    it "returns the first item it matches to a specific created_at" do
      create_list(:item, 4, created_at: "2012-03-04 22:53:51")
      item = Item.first

      get "/api/v1/items/find?created_at=2012-03-04 22:53:51"

      expect(response).to be_success

      raw_item = JSON.parse(response.body)

      expect(raw_item["id"]).to eq(item.id)
    end

    it "returns the first item it matches to a specific updated_at" do
      create_list(:item, 4, updated_at: "2012-03-04 22:53:51")
      item = Item.first

      get "/api/v1/items/find?updated_at=2012-03-04 22:53:51"

      expect(response).to be_success

      raw_item = JSON.parse(response.body)

      expect(raw_item["id"]).to eq(item.id)
    end
  end
end
