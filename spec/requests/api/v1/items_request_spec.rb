require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

  get "/api/vi/items"

  expect(response).to be_success
  end
end
