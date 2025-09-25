# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Artist.destroy_all
Gallery.destroy_all
Painting.destroy_all

artist1 = Artist.create(name: "Test1", age: 20, experience_level: 4)
artist2 = Artist.create(name: "Test2", age: 24, experience_level: 10)

gal1 = Gallery.create(name: "gallery1", location: "MH")
gal2 = Gallery.create(name: "gallery2", location: "GJ")


5.times do
    Painting.create(name: Faker::Name.name, price: Faker::Number.between(from:1000, to:100000), artist_id: Artist.ids.sample, gallery_id: Gallery.ids.sample)
end