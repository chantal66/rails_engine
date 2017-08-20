require 'rails_helper'

RSpec.describe "Item/FindAll API" do
  context "GET /api/v1/items/find_all?params" do
    it "returns all items that match a specific id" do
      create_list(:item, 4)
      item = Item.first

      get "/api/v1/items/find_all?id=#{item.id}"

      expect(response).to be_success

      raw_items = JSON.parse(response.body)
      raw_item = raw_items.first

      expect(raw_items.count).to eq(1)
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

    it "returns all items that match a specific name" do
      create_list(:item, 3)
      item = Item.first

      get "/api/v1/items/find_all?name=#{item.name}"

      expect(response).to be_success

      raw_items = JSON.parse(response.body)
      raw_item = raw_items.first

      expect(raw_item.count).to eq(5)
      expect(raw_item["id"]).to eq(item.id)
      expect(raw_item["name"]).to eq(item.name)
    end

    it "returns all items that match a specific unit_price" do
      create_list(:item, 3, unit_price: 55890)
      item = Item.first
      item_3 = Item.last
      item_4 = create(:item, unit_price: 100)

      get "/api/v1/items/find_all?unit_price=558.9"

      expect(response).to be_success

      raw_items = JSON.parse(response.body)
      raw_item = raw_items.first
      raw_item_3 = raw_items.last

      expect(raw_items.count).to eq(3)
      expect(raw_item["id"]).to eq(item.id)
      expect(raw_item_3["id"]).to_not eq(item_4.id)
      expect(raw_item_3["id"]).to eq(item_3.id)
      expect(raw_item["unit_price"]).to eq("558.9")
    end

    it "returns all items that match a specific description" do
      create_list(:item, 3)
      item = Item.first
      item_3 = Item.last
      item_4 = create(:item, description: "otra cosa")

      get "/api/v1/items/find_all?description=#{item.description}"

      expect(response).to be_success

      raw_items = JSON.parse(response.body)
      raw_item = raw_items.first
      raw_item_3 = raw_items.last

      expect(raw_items.count).to eq(3)
      expect(raw_item["id"]).to eq(item.id)
      expect(raw_item_3["id"]).to_not eq(item_4.id)
      expect(raw_item_3["id"]).to eq(item_3.id)
      expect(raw_item["description"]).to eq(item.description)
    end

    it "returns all items that match a specific merchant id" do
      create_list(:item, 3)
      item = Item.first
      item_3 = Item.last
      item_4 = create(:item, merchant_id: item.merchant_id)

      get "/api/v1/items/find_all?merchant_id=#{item.merchant_id}"

      expect(response).to be_success

      raw_items = JSON.parse(response.body)
      raw_item = raw_items.first
      raw_item_3 = raw_items.last

      expect(raw_items.count).to eq(2)
      expect(raw_item["id"]).to eq(item.id)
      expect(raw_item_3["id"]).to_not eq(item_3.id)
      expect(raw_item_3["id"]).to eq(item_4.id)
      expect(raw_item["merchant_id"]).to eq(item.merchant_id)
    end

    it "returns all items that match a specific created_at" do
      create_list(:item, 3, created_at: "2012-03-04 22:53:51")
      item = Item.first
      item_3 = Item.last
      item_4 = create(:item)

      get "/api/v1/items/find_all?created_at=2012-03-04 22:53:51"

      expect(response).to be_success

      raw_items = JSON.parse(response.body)
      raw_item = raw_items.first
      raw_item_3 = raw_items.last

      expect(raw_items.count).to eq(3)
      expect(raw_item["id"]).to eq(item.id)
      expect(raw_item_3["id"]).to_not eq(item_4.id)
      expect(raw_item_3["id"]).to eq(item_3.id)
    end

    it "returns all items that match a specific updated_at" do
      create_list(:item, 3, updated_at: "2012-03-04 22:53:51")
      item = Item.first
      item_3 = Item.last
      item_4 = create(:item)

      get "/api/v1/items/find_all?updated_at=2012-03-04 22:53:51"

      expect(response).to be_success

      raw_items = JSON.parse(response.body)
      raw_item = raw_items.first
      raw_item_3 = raw_items.last

      expect(raw_items.count).to eq(3)
      expect(raw_item["id"]).to eq(item.id)
      expect(raw_item_3["id"]).to_not eq(item_4.id)
      expect(raw_item_3["id"]).to eq(item_3.id)
    end
  end
end
