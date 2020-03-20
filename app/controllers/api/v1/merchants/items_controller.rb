class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    # require "pry"; binding.pry
    render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
  end
end
