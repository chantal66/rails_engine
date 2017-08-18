class Api::V1::Items::MostItemsController < ApplicationController
  def index
    render json: Item.most_popular_items(params[:quantity]), each_serializer: MostItemsSerializer
  end
end