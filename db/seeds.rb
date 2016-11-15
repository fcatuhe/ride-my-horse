# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Level.destroy_all
Category.destroy_all
User.destroy_all
Horse.destroy_all


Level.create({ name: 'Beginner' })
Level.create({ name: 'Intermediate' })
Level.create({ name: 'Advanced' })

Category.create({ name: 'Horse' })
Category.create({ name: 'Poney' })
Category.create({ name: 'Double-poney' })


Faker::Config.locale = 'fr'

5.times do
  user = User.new({
    email: Faker::Internet.email,
    password: "123456"
    })
  user.encrypted_password="ENCRYPT.MY.ASS!!!KJASOPJ090923ULXCIULSH.IXJ!S920"
  user.save
end


15.times do
  # pic_path = 'horse' + rand(1..10).to_s + '.jpg'
  horse = Horse.new ({
    name: Faker::Pokemon.name,
    price: rand(15..100),
    address: Faker::Address.city,
    equipment: Faker::Boolean.boolean(0.4),
    description: Faker::Hipster.sentences(1)
    # photo: src= pic_path,
    })
  horse.user = User.all[rand(0..4)]
  horse.category = Category.all[rand(0..2)]
  horse.save
end


