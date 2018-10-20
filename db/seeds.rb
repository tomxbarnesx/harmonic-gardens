# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: "admin", first_name: "Harmonic", last_name: "Admin", email: "admin@test.com", user_access: "Admin", hourly_rate: "0", password: "password");
User.create(username: "seanpaul", first_name: "Sean", last_name: "Paul", email: "sean@test.com", user_access: "Foreman", hourly_rate: "30", password: "password");
User.create(username: "jborges", first_name: "Jorge Louis", last_name: "Borges", email: "borges@test.com", user_access: "Foreman", hourly_rate: "30", password: "password");

j = 0

while j < 13
    User.create(username: Faker::Internet.username, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, user_access: "Worker", hourly_rate: "15", password: "password");
    j += 1
end


i = 0

while i < 20
    Client.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, address: Faker::Address.full_address, email: Faker::Internet.email, active: true, home_phone: 3255545445, cell_phone: 3255545445);
    i += 1
end