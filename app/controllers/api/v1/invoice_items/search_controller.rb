class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    render json: InvoiceItem.find(search_params)
  end

  def index
    render json: InvoiceItem.where(search_params)
  end

  def search_params
    params.permit(:id, :quantity, :unit_price, :invoice_id, :item_id)
  end
end
