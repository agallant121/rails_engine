class Api::V1::Items::FindController < ApplicationController

  def show
    render_this
  end
  
  private

  def find_params
    params.permit(:id, :name, :description, :merchant_id, :unit_price, :created_at, :updated_at)
  end

  def render_this
    if params.include?('created_at' || 'updated_at')
      render json: ItemSerializer.new(Item.find_by(find_params))
    else
      items =  Item.where("name like ?", "%#{params['name']}%")
      render json: ItemSerializer.new(items)
    end
  end
end
