# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require "faker"

5.times do
  User.find_or_create_by!(email: Faker::Internet.unique.email) do |user|
    user.full_name = Faker::Name.name
  end
end

5.times do
  author = Author.find_or_create_by!(full_name: Faker::Book.author)

  Book.find_or_create_by!(author: author, title: Faker::Book.title)
end
