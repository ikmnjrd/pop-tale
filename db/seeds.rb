# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "shingo",
    email: "thanks@yaecho.jp",
    password:              "949sYfiCy5wxGst73bI99Ghost",
    #password_confirmation: "949sYfiCy5wxG",
    admin: true,
    #activated: true,
    #activated_at: Time.zone.now,
    confirmed_at: Time.zone.now)


45.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(name:  name,
      email: email,
      password:              password,
      #password_confirmation: password,
      #activated: true,
      #activated_at: Time.zone.now,
      confirmed_at: Time.zone.now)
end

first_user = User.first
first_user.paintings.create!(description: "a first tree", picture: open("#{Rails.root}/db/fixtures/hazimete_no_tree.jpg"), activated: true, price: 1000000)
first_user.paintings.create!(description: "骨になったクジラ", picture: open("#{Rails.root}/db/fixtures/shinkai_kujira_hone.png"), activated: true, price: 10000)
first_user.paintings.create!(description: "セミクジラ", picture: open("#{Rails.root}/db/fixtures/whale_03_semikujira.png"), activated: true, price: 10000, purchase_id: 2)
first_user.paintings.create!(description: "コククジラ", picture: open("#{Rails.root}/db/fixtures/whale_07_kokukujira.png"), activated: true, price: 10000)

second_user = User.second
second_user.paintings.create!(description: "ヤンキー", picture: open("#{Rails.root}/db/fixtures/furyo_shounen.png"), activated: true, price: 10000)
second_user.paintings.create!(description: "打倒東京スカイツリー", picture: open("#{Rails.root}/db/fixtures/tokyo_tower.jpg"), activated: true, price: 400000)
second_user.paintings.create!(description: "wall of nuts", picture: open("#{Rails.root}/db/fixtures/tyjfjykgo.jpg"), activated: true, price: 99999)


list = ['red', 'blue', 'yellow', 'asshole']
list.each do |tag|
  ActsAsTaggableOn::Tag.new(:name => tag).save
end

first_paint = Painting.first
first_paint.tag_list.add("big", "whale")
first_paint.save

second_paint = Painting.second
second_paint.tag_list.add("whale","dead")
second_paint.save

third_paint = Painting.find(3)
third_paint.tag_list.add("whale")
third_paint.save

fourth_paint = Painting.find(4)
fourth_paint.tag_list.add("whale")
fourth_paint.save

sixth_paint = Painting.find(6)
sixth_paint.reload
sixth_paint.tag_list.add("tokyo","夜景","東京タワー")
sixth_paint.save