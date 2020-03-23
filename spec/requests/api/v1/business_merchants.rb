# require 'rails_helper'
#   RSpec.describe 'merchant business' do
#     before :each do
#       @merchant_1 = create(:merchant)
#       @merchant_2 = create(:merchant)
#       item_1 = create(:item, merchant: @merchant_1, unit_price: 1000)
#       item_2 = create(:item, merchant: @merchant_2, unit_price: 2000)
#       @created_at_1 = '2012-03-16T14:54:05.000Z'
#       @created_at_2 = '2012-03-07T14:54:05.000Z'
#       invoice_1 = create(:invoice, merchant: @merchant_1, created_at: @created_at_1)
#       invoice_2 = create(:invoice, merchant: @merchant_2, created_at: @created_at_1)
#       invoice_3 = create(:invoice, merchant: @merchant_1, created_at: @created_at_2)
#       invoice_4 = create(:invoice, merchant: @merchant_2, created_at: @created_at_2)
#       @invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 2, unit_price: item_1.unit_price, created_at: @created_at_1)
#       @invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 2, unit_price: item_2.unit_price, created_at: @created_at_1)
#       @invoice_item_3 = create(:invoice_item, item: item_1, invoice: invoice_3, quantity: 2, unit_price: item_1.unit_price, created_at: @created_at_2)
#       @invoice_item_4 = create(:invoice_item, item: item_2, invoice: invoice_4, quantity: 2, unit_price: item_2.unit_price, created_at: @created_at_2)
#       create(:transaction, invoice_id: invoice_1.id)
#       create(:transaction, invoice_id: invoice_2.id)
#       create(:transaction, invoice_id: invoice_3.id)
#       create(:transaction, invoice_id: invoice_4.id)
#     end
#
#   it "two highest grossing merchants" do
#     get "/api/v1/merchants/most_revenue?quantity=1"
#
#     expect(response).to be_successful
#     result = JSON.parse(response.body)['data'][0]['id']
#     expect(result).to eq(@merchant_2.id.to_s)
#
#     get "/api/v1/merchants/most_revenue?quantity=2"
#
#     expect(response).to be_successful
#     result = JSON.parse(response.body)['data'][1]['id']
#     expect(result).to eq(@merchant_1.id.to_s)
#   end
# end
