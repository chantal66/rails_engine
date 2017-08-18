class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    if params[:date]
      render json: Merchant.revenue_for_one_merchant_by_date(params[:id], params[:date]), serializer: RevenueByDateForOneMerchantSerializer
    else
      render json: Merchant.revenue_for_one_merchant(params[:id]), serializer: RevenueForOneMerchantSerializer
    end
  end

  def index
   render json: Merchant.most_revenue(search_params[:quantity])
  end
end
