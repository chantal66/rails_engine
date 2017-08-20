class Api::V1::InvoiceItems::FindController < ApplicationController
  def show
    if params[:unit_price]
      params[:unit_price] = params[:unit_price].to_f*100
    end
    render json: InvoiceItem.find_by(invoice_item_params)
  end

  def index
    render json: InvoiceItem.where(invoice_item_params)
  end

  def invoice_item_params
    params.permit(:id, :quantity, :unit_price, :invoice_id, :item_id, :created_at, :updated_at)
  end
end
