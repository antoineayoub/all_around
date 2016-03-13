# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Message.destroy_all
Request.destroy_all

User.destroy_all

user1 = User.create!(email:"laurent@volunteering.org", password:"12345678", first_name:"Laurent", last_name:"Kretz", phone:"06 00 00 00 00", gender:"male", age: 28, country_of_origin: "Syria", address: "32 rue du Chateau d'eau 75019 Paris", arrival_date: Time.now, category:"volunteer")
user2 = User.create!(email:"max@volunteering.org", password:"12345678", first_name:"Maxime", last_name:"Delpit", phone:"06 00 00 00 00", gender:"male", age: 28, country_of_origin: "Syria", address: "32 rue du Chateau d'eau 75019 Paris", arrival_date: Time.now, category:"volunteer")
user3 = User.create!(email:"antoine@techfugee.org", password:"12345678", first_name:"Antoine", last_name:"Ayoub", phone:"06 00 00 00 00", gender:"male", age: 28, country_of_origin: "Syria", address: "32 rue du Chateau d'eau 75019 Paris", arrival_date: Time.now, category:"refugee")

user3.requests.create!(content:"I am looking for a doctor", status:"not_assigned", category:"medkit")
user3.requests.create!(content: "Where can I learn French?", status: "solved", category:"graduation-cap", volunteer: user1)
user3.requests.create!(content:"Where can I do sport with other persons from Syria?", status:"not_assigned", category:"futbol-o")
user3.requests.create!(content:"What is the first administrative process to follow?", status:"solved", category:"balance-scale", volunteer: user2)

