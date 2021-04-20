# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# user = User.find_by(email: 'victor.j.fdez@gmail.com')

# if user
#   race = Race.create(
#     title: 'Test race',
#     segment_id: '4677383'
#   )

#   race_category = RaceCategory.create(
#     title: 'Special category race',
#     price: 30,
#     race_id: race.id
#   )

#   Registration.create(
#     race_id: race.id,
#     user_id: user.id,
#     race_category_id: race_category.id,
#     status: true
#   )
# end

puts 'Reseting PK sequence on all tables..'
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts 'Seeding...'

Dir[Rails.root.join('db/seeds/*.rb')].sort.each do |file|
  puts "Processing #{file.split('/').last}"
  require file
end

puts 'Done!'