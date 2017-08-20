class Api::V1::Items::BestDayController < ApplicationController

  def index
    render json: Item.best_day(params[:item_id]), each_serializer: BestDaySerializer
  end
end