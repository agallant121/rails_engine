FactoryBot.define do
  factory :item do
    name { Faker::TvShows::BreakingBad.character }
    description { Faker::TvShows::DumbAndDumber.quote}
    unit_price { rand(1.00..99.99).round(2) }
    merchant
  end
end
