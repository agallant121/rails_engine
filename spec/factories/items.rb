FactoryBot.define do
  factory :item do
    name { "Banana Stand" }
    description { "There's always money in the banana stand." }
    unit_price { 125.55 }
    # created_at { "2012-03-27 14:53:59 UTC" }
    # updated_at { "2013-03-27 14:53:59 UTC" }
    merchant
  end
end
