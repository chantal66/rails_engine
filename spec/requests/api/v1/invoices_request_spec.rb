require 'rails_helper'
require 'pry'
describe "Invoices API" do
  it "sends a list of invoices" do
    create_list(:invoice, 3)

    get '/api/v1/invoices'

    expect(response).to be_success
    invoices = JSON.parse(response.body)
    expect(invoices.count).to eq(3)
   end

  it "can get one invoice by its id" do
    id = create(:invoice).id

    get "/api/v1/invoices/#{id}"

    expect(response).to be_success
    invoice = JSON.parse(response.body)
    expect(invoice["id"]).to eq(id)
  end

  it "returns a single invoice by status" do
    id = create(:invoice, status: "success").id
    create(:invoice, status: "success")

    get "/api/v1/items/find?status=success"
    binding.pry
    expect(response).to be_success
    #response.success?
    invoice = JSON.parse(response.body)
    expect(invoice["id"]).to eq(id)
  end

  it "returns all matches by merchant_id" do
    create_list(:merchant, 3)
    merchant = Merchant.first
    create_list(:item, 5, merchant: merchant)
    create(:item, merchant_id: Merchant.last.id)

    get "/api/v1/invoices/find_all?merchant_id=#{merchant.id}"

    expect(response).to be_success

    invoices = JSON.parse(response.body)
    expect(invoices.count).to eq(5)
    expect(invoices.sample["merchant_id"]).to eq(Merchant.first.id)
  end

  it "returns a random resource" do
    create_list(:invoice, 5)

    get "/api/v1/invoices/random.json"

    expect(response).to be_success
    invoice = JSON.parse(response.body)
    expect(invoice.count).to eq(1)
  end
end
