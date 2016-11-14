# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Level.create({ name: 'Beginner' })
Level.create({ name: 'Intermediate' })
Level.create({ name: 'Advanced' })

Category.create({ name: 'Horse' })
Category.create({ name: 'Poney' })
Category.create({ name: 'Double-poney' })


