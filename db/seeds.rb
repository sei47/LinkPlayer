# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do |n|
  name = Faker::Games::Zelda.game
  info = Faker::Games::Zelda.location
  Game.create!(name: name,
              info: info
              )
end

10.times do |n|
  name = Faker::Games::Zelda.item
  Tag.create!(name: name)
end

5.times do |n|
  name = Faker::Games::Zelda.item
  create_user_id = n + 1
  comment = "test#{n + 1}"
  game_id = n + 1
  Community.create!(name: name,
                    comment: comment,
                    create_user_id: create_user_id,
                    game_id: game_id)
end

5.times do |n|
  name = Faker::Games::Pokemon.name
  email = "#{n + 1}@email.com"
  password = "#{n + 1}@email.com"
  admin = false
  User.create!(name: name,
              email: email,
              password: password,
              admin: admin)
end
