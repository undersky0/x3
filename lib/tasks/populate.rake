namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'faker'
  # Faker::Config.locale = :engb
     #Rake::Task['db:reset'].invoke
     

50.times do |n|
                displayName = Faker::Name.name
                email = "test-#{n+2918}@tests.org"
                password = "password"
                # test_user = User.create!(
                  # :email => email,
                  # :password => password,
                  # :password_confirmation => password) 
               
               test_user = User.first

                
                # location = test_user.build_location(:address => Faker::Address.street_name,
                # :street_address => Faker::Address.street_name,
                # :postcode => Faker::Address.postcode,
                # :latitude => Faker::Address.latitude,
                # :longitude => Faker::Address.longitude,
                # :google_address => Faker::Address.street_name,
                # :city => Faker::Address.city)


                skilltype = SkillType.create(:name => Faker::Commerce.department,
                :description => Faker::Company.catch_phrase)
                
                skills = test_user.skills.build(
                :name => Faker::Hacker.ingverb,
                :description => Faker::Hacker.say_something_smart,
                :skill_type_id => skilltype.id,
                :level => "Beginners",
                :required_experience => Faker::Lorem.characters(10),
                :start_date => rand(1.year).from_now,
                :max_students => n,
                :min_students => Faker::Number.digit,
                :price => Faker::Number.digit,
                :user_id => test_user.id,
                :location_id => test_user.location.id,
                :activity_duration => Faker::Number.digit,
                :teachers_title => Faker::Name.title)
                # location.save
                # test_user.build_useravatar
                # test_user.build_usercover
                # test_user.save
                skills.save
                # ward = Ward.new(:city => location.city, :locality => location.locality, :location_id => location.id)
                # localfeed = Localfeed.new(:city => location.city, :location_id => location.id)
                # ward.save
                # localfeed.save
                slocation = skills.build_location(:address => test_user.location.street_name,
                :street_address => test_user.location.street_name,
                :postcode => test_user.location.postcode,
                :latitude => test_user.location.latitude,
                :longitude => test_user.location.longitude,
                :google_address => test_user.location.street_name,
                :city => test_user.location.city)
                slocation.save

                # group = test_user.groups.build(
                # :name => Faker::Company.name,
                # :group_type => "public",
                # :privacy => "public",
                # :about => Faker::Hacker.say_something_smart,
                # :headline => Faker::Company.catch_phrase)
#                 
                # group.save
                # gl = group.build_location(:address => Faker::Address.street_name,
                # :street_address => Faker::Address.street_name,
                # :postcode => Faker::Address.postcode,
                # :latitude => Faker::Address.latitude,
                # :longitude => Faker::Address.longitude,
                # :google_address => Faker::Address.street_name,
                # :city => Faker::Address.city)
                # gl.save
#                 
                
                
end                
end
end