FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { Faker::Number.number(digits: 16) }
    credit_card_expiration_date { }
    result { "success" }
  end
end
