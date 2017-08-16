class Api::V1::Merchants::FindAllController < ApplicationController

  def show
    render json: Merchant.where(merchant_params)
  end
  
  private

  def merchant_params
    params.permit(:id, :name, :created_at, :update_at)
  end
end