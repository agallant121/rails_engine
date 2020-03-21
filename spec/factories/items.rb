FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Movies::PrincessBride.quote }
    unit_price { rand(1.00..99.99).round(2) }
    merchant
  end
end
