# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if User.where(email: "admin@example.com").blank?
  user = User.new(
    email: "admin@example.com",
    password: "password",
    password_confirmation: "password"
  )
  user.save!
end