# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

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