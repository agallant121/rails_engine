require 'rails_helper'

describe "Items API" do
  before :each do
    Item.destroy_all
  end

  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)['data']
    expect(items.count).to eq(3)
  end

  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(item["id"].to_i).to eq(id)
  end

  it "can create a new item" do
    merchant = create(:merchant)

    item_params = { name: "Saw",
                    description: "I want to play a game",
                    unit_price: 50.55,
                    merchant_id: merchant.id }

    post "/api/v1/items", params: item_params
    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
  end

  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "Sledge" }

    put "/api/v1/items/#{id}", params: item_params
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Sledge")
  end

  it "can destroy an item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can find the item's merchant" do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)

    new_item = Item.last

    get "/api/v1/items/#{new_item.id}/merchant"

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(response).to be_successful
    expect(merchant[:id]).to eq(merchant_1.id.to_s)
  end

  it "can find one item by name param" do
    item_1 = create(:item)

    get "/api/v1/items/find?name=#{item_1.name}"

    item = JSON.parse(response.body)["data"]
    
    expect(response).to be_successful
    expect(item["attributes"]['name']).to eq(item_1.name)
  end

  it "can find one item by description param" do
    item_1 = create(:item)

    get "/api/v1/items/find?description=#{item_1.description}"

    item = JSON.parse(response.body)["data"]
    
    expect(response).to be_successful
    expect(item["attributes"]['description']).to eq(item_1.description)
  end

  it "can find one item by unit price param" do
    item_1 = create(:item)

    get "/api/v1/items/find?unit_price=#{item_1.unit_price}"

    item = JSON.parse(response.body)["data"]
    
    expect(response).to be_successful
    expect(item["attributes"]['unit_price']).to eq(item_1.unit_price)
  end

  it "can find one item by id param" do
    item_1 = create(:item)

    get "/api/v1/items/find?id=#{item_1.id}"

    item = JSON.parse(response.body)["data"]
    
    expect(response).to be_successful
    expect(item['id'].to_i).to eq(item_1.id)
  end
end
