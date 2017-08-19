class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def show
    render json: Merchant.favorite_customer(params[:id]), serializer: FavoriteCustomerSerializer

    # id = Merchant.find(params[:id])
    # render json: Customer.favorite_customer(id)
  end
end
