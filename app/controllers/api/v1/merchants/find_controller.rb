class Api::V1::Merchants::FindController < ApplicationController

  def show
    render_this
  end

  private

   def find_params
     params.permit(:id, :name, :created_at, :updated_at)
   end

   def render_this
     if params.include?('created_at' || 'updated_at')
       render json: MerchantSerializer.new(Merchant.find_by(find_params))
     else
       merchants =  Merchant.where("name like ?", "%#{params['name']}%")
       render json: MerchantSerializer.new(merchants)
     end
   end
end
