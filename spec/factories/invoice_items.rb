FactoryBot.define do
factory :invoice_item do
  item
  invoice
  quantity { Faker::Number.number(digits: 2) }
  unit_price { item.unit_price }
end
end
