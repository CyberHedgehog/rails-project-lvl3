# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
# movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# Character.create(name: 'Luke', movie: movies.first)
user = User.create(email: 'admin@example.com', password: 'admin', password_confirmation: 'admin', is_admin: true)
%i[Hobby Transport Electronics Sports Health].each do |item|
  Category.create(name: item)
end

categories = Category.all

5.times do
  Bulletin.create(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    user_id: user.id,
    category_id: categories.sample.id
  )
end
