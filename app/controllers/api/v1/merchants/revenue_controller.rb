class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    render json: Merchant.revenue_for_one_merchant(params[:id])
  end
end