class Api::V1::Invoices::SearchController < ApplicationController

  def show
    render json: Invoice.find_by(search_value)
  end

  def index
    render json: Invoice.where(search_value)
  end

  def search_value
    params.permit(:status, :merchant_id, :customer_id, :updated_at, :created_at, :id)
  end
end
