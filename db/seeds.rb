# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#every seed in the folder
#Dir[File.join(Rails.root, 'db', 'sample_seeds', '*.rb')].sort.each do |seed|
#  load seed
#end

#set admin
admin = User.find(3)
admin.update_attribute(:superadmin_role, true)
