require('pry')
require_relative('../models/user')

User.delete_all()

user = User.new({"name" => "Darren"})
user.save()

user2 = User.new({"name" => "John"})
user2.save()

user3 = User.new({"name" => "Zsolt"})
user3.save()

user4 = User.new({"name" => "Sandy"})
user4.save()

puts User.all()

puts "Please enter your name"
new_user = gets.chomp

user5 = User.new({"name" => new_user})
user5.save()

pry