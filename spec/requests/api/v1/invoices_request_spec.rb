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

  xit "returns a single invoice by status" do
    id = create(:invoice, status: "new").id
    create(:invoice, status: "new")

    get "/api/v1/items/find?status=new"

    expect(response).to be_success
    invoice = JSON.parse(response.body)
    expect(invoice['id']).to eq(id)
  end

  it "returns all matches by merchant_id" do
    create_list(:merchant, 3)
    create_list(:invoice, 5, merchant_id: Merchant.first.id)
    id = create(:invoice, merchant_id: Merchant.last.id).id

    get "/api/v1/invoices/find_all?merchant_id=#{Merchant.first.id}"

    expect(response).to be_success

    invoices = JSON.parse(response.body)
    expect(invoices.count).to eq(5)
    expect(invoices.sample["id"]).to_not eq(id)
  end

  it "returns a random resource" do
    create_list(:invoice, 5)

    get "/api/v1/invoices/random.json"

    expect(response).to be_success
    invoice = JSON.parse(response.body)
    expect(invoice.count).to eq(1)
  end
end
