require 'rails_helper'

describe "Customers API" do
  context 'GET /api/v1/customers' do
    it "sends a All customers" do
      create_list(:customer, 4)

      get '/api/v1/customers'

      expect(response).to be_success
      raw_customers = JSON.parse(response.body)
      raw_customer = raw_customers.first

      expect(response).to have_http_status(200)
      expect(raw_customers.count).to eq(4)
      expect(raw_customer).to have_key("first_name")
      expect(raw_customer).to have_key("last_name")
      expect(raw_customer["first_name"]).to be_a String
      expect(raw_customer["last_name"]).to be_a String
    end
  end

  context 'GET /api/v1/customers/:id' do
    it 'sends one customer' do
      customer = create(:customer)

      get "/api/v1/customers/#{customer.id}"

      expect(response).to be_success

      raw_customer = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(raw_customer["id"]).to eq(customer.id)
      expect(raw_customer).to have_key("first_name")
      expect(raw_customer).to have_key("last_name")
      expect(raw_customer["first_name"]).to be_a String
      expect(raw_customer["last_name"]).to be_a String
    end
  end
end