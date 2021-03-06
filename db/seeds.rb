# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

User.create(name: 'admin', lastname: 'admin', email: 'christophe.loeys@gmail.com', dateofbirth: Date.new(1992, 2, 16), password: 'admin')

50.times do
  Cost.create(title: Faker::Lorem.word, description: Faker::Lorem.sentence, code: Faker::Internet.domain_suffix, amount: 15.0, paid: false, user_id: User.first.id)
end
