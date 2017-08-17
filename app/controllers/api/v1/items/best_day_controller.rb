class Api::V1::Items::BestDayController < ApplicationController

  def index
    render json: Item.best_day(params[:id]), serializer: BestDaySerializer
  end
end