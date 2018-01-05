require 'random_data'
require 'faker'

# Create Users
10.times do
  User.create!(
   email: Faker::Internet.email,
   password: Faker::Internet.password(10),
  )
end

# Create Users
  User.create!(
   email: 'admin@admin.com',
   password: 'admin123!',
  )
  
   users = User.all

 # Create Wikis
 50.times do
   Wiki.create!(
     title:  Faker::WorldOfWarcraft.quote,
     body:   Faker::WorldOfWarcraft.quote,
     private: true,
     user: users.sample
   )
 end
 

 wikis = Wiki.all
 
 puts "Seed finished"
 puts "#{Wiki.count} wikis created"
 puts "#{User.count} users created"
