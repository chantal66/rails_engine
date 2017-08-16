require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_success
    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
   end

  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    expect(response).to be_success
    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end

  it "returns a single object by name" do
    id = create(:item, name: "object_name").id
    create(:item, name: "object_name")

    get "/api/v1/items/find?name=object_name"

    expect(response).to be_success
    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end

  it "returns a single object by description" do
    id = create(:item, description: "object_description").id
    create(:item, description: "object_description")

    get "/api/v1/items/find?description=object_description"

    expect(response).to be_success
    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end

  it "returns a single object by unit_price" do
    id = create(:item, unit_price: 15.50).id
    create(:item, unit_price: 15.50)

    get "/api/v1/items/find?unit_price=15.50"

    expect(response).to be_success
    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end

  it "returns a single object by merchant_id" do
    create_list(:merchant, 3)
    create(:item, merchant: Merchant.last)
    id = create(:item, merchant: Merchant.last).id

    get "/api/v1/items/find?merchant_id=#{Merchant.last.id}"

    expect(response).to be_success
    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end

  it "returns a single object by created_at" do
    id = create(:item, created_at: "10 January 2017").id
    create(:item, created_at: "10 January 2017")

    get "/api/v1/items/find?created_at=10 January 2017"

    expect(response).to be_success
    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end

  it "returns a single object by updated_at" do
    id = create(:item, updated_at: "15 May 2017").id
    create(:item, updated_at: "15 May 2017")
    get "/api/v1/items/find?updated_at=15 May 2017"

    expect(response).to be_success
    item = JSON.parse(response.body)
    expect(item["id"]).to eq(id)
  end

  it "returns all matches by name" do
      create_list(:item, 10, name: "item name")
      create(:item, name: "my name is hello")

      get "/api/v1/items/find_all?name=item name"

      expect(response).to be_success
      expect(items.count).to eq(10)

      items = JSON.parse(response.body)
      expect(items.sample["name"]).to eq("item name")
  end

  it "returns all matches by description" do
    create_list(:item, 5, description: "I want to find the item with this description")
    create(:item, description: "Do not return the item with this description")

    get "/api/v1/items/find_all?description=I want to find the item with this description"

    expect(response).to be_success
    expect(items.count).to eq(5)

    items = JSON.parse(response.body)
    expect(items.sample["description"]).to eq("I want to find the item with this description")
  end

  it "returns all matches by unit_price" do
    create_list(:item, 5, unit_price: 100.90)
    create(:item, unit_price: 80.80)
    get "/api/v1/items/find_all?unit_price=100.90"

    expect(response).to be_success
    expect(items.count).to eq(5)

    items = JSON.parse(response.body)
    expect(items.sample["unit_price"]).to eq(100.90)
  end

  it "returns all matches by merchant_id" do
    create_list(:merchant, 3)
    create_list(:item, 5, merchant_id: Merchant.first.id)
    create(:item, merchant_id: Merchant.last.id)

    get "/api/v1/items/find_all?merchant_id=#{Merchant.first.id}"

    expect(response).to be_success
    expect(items.count).to eq(5)

    items = JSON.parse(response.body)
    expect(items.sample["merchant_id"]).to eq(Merchant.first.id)
  end

  it "returns all matches by created_at" do
    create_list(:item, 5, created_at: "10 January 2016")
    create(:item, created_at: "20 February 2010")

    get "/api/v1/items/find_all?created_at=10 January 2016"

    expect(response).to be_success
    #items = JSON.parse(response.body)
    expect(items.count).to eq(5)
  end

  it "returns all matches by updated_at" do
    create_list(:item, 5, updated_at: "20 July 2017")
    create(:item, updated_at: "25 June 2015")

    get "/api/v1/items/find_all?updated_at=20 July 2017"

    expect(response).to be_success
    items = JSON.parse(response.body)
    expect(items.count).to eq(5)
  end

  it "returns a random resource" do
    create_list(:item, 5)

    get "api/v1/items/random.json"

    expect(response).to be_success
    item = JSON.parse(response.body)
    expect(item.count).to eq(1)
  end
end
