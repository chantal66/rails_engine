class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    render json: InvoiceItem.find(search_params[:id])
  end

  def index
    render json: InvoiceItem.all
  end

  def search_params
    params.permit(:quantity, :unit_price, :invoice_id, :item_id)
  end
end
