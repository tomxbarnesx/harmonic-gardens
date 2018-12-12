# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: "admin", first_name: "Harmonic", last_name: "Admin", email: "harmonictest@test.com", role: "Admin", hourly_rate: "1", password: "password", phone_number: "5555555555");
User.create(username: "xtbxadmin", first_name: "Super", last_name: "Admin", email: "admin2@test.com", role: "Admin", hourly_rate:"1", password:"password", phone_number:"5555555555");