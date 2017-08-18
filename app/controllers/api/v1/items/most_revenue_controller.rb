class Api::V1::Items::MostRevenueController < ApplicationController

  def index
    render json: Item.most_revenue(search_params[:quantity])
  end

  def search_params
    params.permit(:quantity)
  end
end
