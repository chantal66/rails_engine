require 'rails_helper'

describe "Merchants API" do
  it "sends a All merchants" do
    create_list(:merchant, 4)

    get '/api/v1/merchants'

    expect(response).to be_success
  end
end