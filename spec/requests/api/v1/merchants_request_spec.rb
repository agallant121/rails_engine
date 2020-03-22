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

  it "can find one merchant by name endpoint" do
    merchant_1 = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant_1.name}"

    merchant = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(merchant[0]['attributes']['name']).to eq(merchant_1.name)
  end

  it "can find one merchant by id endpoint" do
    merchant_1 = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant_1.id}"

    merchant = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(merchant[0]['id'].to_i).to eq(merchant_1.id)
  end

  it "can find one merchant by created_at endpoint" do
    merchant_1 = create(:merchant, created_at: '2012-03-27 14:53:59 UTC')
    # why would I need to specify timestamp here when it is already created?
    get "/api/v1/merchants/find?created_at=#{merchant_1.created_at}"

    merchant = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(merchant.keys).to include('id')
    expect(merchant['attributes'].keys).to include('name')
    expect(merchant['attributes'].keys).to_not include('created_at')
  end

  it "can find one merchant by updated_at endpoint" do
    merchant_1 = create(:merchant, updated_at: '2012-03-27 14:53:59 UTC')

    get "/api/v1/merchants/find?updated_at=#{merchant_1.updated_at}"

    merchant = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(merchant[0].keys).to include('id')
    expect(merchant[0]['attributes'].keys).to include('name')
    expect(merchant[0]['attributes'].keys).to_not include('updated_at')
  end

  it "can find partial matches" do
    merchant_1 = create(:merchant, name: "Banana Stand")

    get "/api/v1/merchants/find?name=ana"

    merchant = JSON.parse(response.body)['data']

    expect(merchant[0]['attributes']['name']).to eq(merchant_1.name)
  end

  it 'can find all merchant records by string fragment' do
    merchant_1 = create(:merchant, name: "aldo")
    merchant_2 = create(:merchant, name: "Waldo")

    get "/api/v1/merchants/find_all?name=aldo"

    merchants = JSON.parse(response.body)['data']
    
    expect(response).to be_successful
    expect(merchants.count).to eq(2)
    expect(merchants.first['attributes']['name']).to eq(merchant_1.name)
    expect(merchants.last['attributes']['name']).to eq(merchant_2.name)
  end
end
