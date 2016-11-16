# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

print "Destroying everything"
Level.destroy_all
Booking.destroy_all
Horse.destroy_all
Category.destroy_all
User.destroy_all
puts "   💥"


print "Creating levels"
Level.create({ name: 'Beginner' })
Level.create({ name: 'Intermediate' })
Level.create({ name: 'Advanced' })
puts "      💥"

print "Creating categories"
Category.create({ name: 'Horse' })
Category.create({ name: 'Poney' })
Category.create({ name: 'Double-poney' })
puts "    💥"

Faker::Config.locale = 'fr'


5.times do
  user = User.new({
    email: Faker::Internet.email,
    password: "123456"
    })
  user.encrypted_password="ENCRYPT.MY.ASS!!!KJASOPJ090923ULXCIULSH.IXJ!S920"
  user.save
end

print "Creating horse"
10.times do
  horsepath = "horse" + rand(1..11).to_s
  horse = Horse.new ({
    name: Faker::Pokemon.name,
    price: rand(15..100),
    address: "#{Faker::Address.city}, France",
    equipment: Faker::Boolean.boolean(0.4),
    description: Faker::Hipster.sentence,
    photo_url: "http://res.cloudinary.com/fcatuhe/image/upload/v1479227624/#{horsepath}.jpg"
  })
  horse.user = User.all[rand(0..4)]
  horse.category = Category.all[rand(0..2)]
  horse.availabilities.new(start_at: Date.today - 1, finish_at: Date.today + rand(5..20))
  horse.save
  print "🐎  "
end

10.times do
  booking = Booking.new ({
    owner_comment: Faker::ChuckNorris.fact,
    owner_rating: rand(1..5),
    user_comment: Faker::ChuckNorris.fact,
    user_rating: rand(1..5),
    date: Faker::Date.forward(100)
    })
  booking.user = User.all[rand(0..4)]
  booking.horse = Horse.all[rand(0..9)]
  booking.save
end

puts "Seed done 😂"

