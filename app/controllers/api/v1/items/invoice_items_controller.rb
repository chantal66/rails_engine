class Api::V1::Items::InvoiceItemsController < ApplicationController
  def index
    render json: Item.find(params[:is]).invoice_items
  end
end
