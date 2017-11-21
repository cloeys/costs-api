FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email }
    saldo { Faker::Number.decimal(2) }
    dateofbirth { Faker::Date.birthday(9, 99) }
    password 'foobar'
  end
end
