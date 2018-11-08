# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
categories = Category.create([{category_name: "Board Games"},
                              {category_name: "Books"},
                              {category_name: "Camping Gears"},
                              {category_name: "Cars & Vehicles"},
                              {category_name: "Furniture"},
                              {category_name: "Jewelry	&	Clothes"},
                              {category_name: "Kids Costums"},
                              {category_name: "Office Supplies"},
                              {category_name: "Sports Equipments"},
                              {category_name: "Tools"},
                              {category_name: "Toys"},
                              {category_name: "Video Games"}])
@user_profile = UserProfile.find(1)
@user_profile.items.create(:item_name => "watermelon", :category_id => "1")
ß
