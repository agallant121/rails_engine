require 'rails_helper'

describe "Items API" do
  before :each do
    Merchant.destroy_all
  end

  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    items = JSON.parse(response.body)['data']
    expect(items.count).to eq(3)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(merchant["id"].to_i).to eq(id)
  end

  it "can create a new merchant" do

    merchant_params = { name: "Front Row Video"}

    post "/api/v1/merchants", params: merchant_params
    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
  end

  it "can update an existing merchant" do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { name: "Front Row Video" }

    put "/api/v1/merchants/#{id}", params: merchant_params
    merchant = Merchant.find_by(id: id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq("Front Row Video")
  end

  it "can destroy an merchant" do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "shows all items for a specific merchant" do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    item_2 = create(:item, merchant: merchant_1)
    item_3 = create(:item, merchant: merchant_1)


    get "/api/v1/merchants/#{merchant_1.id}/items"

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful
    expect(items.count).to eq(3)
  end

  it "can find one merchant by name param" do
    merchant_1 = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant_1.name}"

    merchant = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(merchant['attributes']['name']).to eq(merchant_1.name)
  end
end
