# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(username: "admin", first_name: "HG", last_name: "Admin", email: "admin@test.com", user_access: "Admin", hourly_rate: "0", password: "password");
User.create(username: "seanpaul", first_name: "Sean", last_name: "Paul", email: "sean@test.com", user_access: "Worker", hourly_rate: "10", password: "password");

Client.create(first_name: "Sheri", last_name: "Gardner", address: "122 Cherry Lane, Greenwich, CT 06870", email: "sherry@test.com", active: true);
Client.create(first_name: "Bill", last_name: "Portcolis", address: "14 Byram Road, Greenwich, CT 06870", email: "bill@test.com", active: true);
Client.create(first_name: "Frank", last_name: "Sinatra", address: "69 Friends Road, Riverside, CT 06878", email: "frank@test.com", active: false);