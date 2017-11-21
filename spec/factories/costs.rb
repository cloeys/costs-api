FactoryBot.define do
  factory :cost do
    title { Faker::App.name }
    description { Faker::Lorem.sentence }
    code { Faker::Internet.domain_suffix }
    amount { Faker::Number.decimal(2) }
    paid { false }
    user_id nil
  end
end
