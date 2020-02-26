# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(name:  "Example User",
    email: "example@railstutorial.org",
    password:              "foobar",
    password_confirmation: "foobar",
    admin: true,
    activated: true,
    activated_at: Time.zone.now)

99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(name:  name,
      email: email,
      password:              password,
      password_confirmation: password,
      activated: true,
      activated_at: Time.zone.now)
end

first_user = User.first
first_user.paintings.create!(description: "座礁したクジラ", picture: open("#{Rails.root}/db/fixtures/kujira_zasyou.png"), activated: true, price: 10000)
first_user.paintings.create!(description: "骨になったクジラ", picture: open("#{Rails.root}/db/fixtures/shinkai_kujira_hone.png"), activated: false, price: 10000)
first_user.paintings.create!(description: "セミクジラ", picture: open("#{Rails.root}/db/fixtures/whale_03_semikujira.png"), activated: true, price: 10000)
first_user.paintings.create!(description: "コククジラ", picture: open("#{Rails.root}/db/fixtures/whale_07_kokukujira.png"), activated: true, price: 10000)

second_user = User.second
second_user.paintings.create!(description: "ヤンキー", picture: open("#{Rails.root}/db/fixtures/furyo_shounen.png"), activated: true, price: 10000)