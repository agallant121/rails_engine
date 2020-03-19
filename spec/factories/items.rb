FactoryBot.define do
  factory :item do
    name { "Banana Stand" }
    description { "There's always money in the banana stand." }
    unit_price { 125.55 }
    merchant
  end
end
