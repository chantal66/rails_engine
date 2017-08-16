class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: Item.find_by(search_value)
  end

  def index
    render json: Item.where(search_value)
  end

  private

  def search_value
    params.permit(:name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end
