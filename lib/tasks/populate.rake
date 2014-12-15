namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'faker'
  # Faker::Config.locale = :engb
     #Rake::Task['db:reset'].invoke
     

                displayName = Faker::Name.name
                email = "test-#{23+11238}@tests.org"
                password = "password"
                test_user = User.create!(
                  :email => email,
                  :password => password,
                  :password_confirmation => password) 
                  
                location = test_user.build_location(:address => "116 Farringdon Road",
                :street_address => "116 Farringdon Road",
                :postcode => "EC1R 3AP",
                :latitude => 51.5255389407005,
                :longitude => -0.1110795637328,
                :google_address => "116 Farringdon Road",
                :city => "London",
                :locality => "Clerkenwell",
                :political => "Islington South and Finsbury",
                :type => "Localfeed")


                ward = Ward.new(:city => location.city, :locality => location.locality)
                ward.save
                                location.save
                test_user.build_useravatar
                test_user.build_usercover
                test_user.save

50.times do |n|
                
               
               # test_user = User.first



                skilltype = SkillType.create(:name => Faker::Commerce.department,
                :description => Faker::Company.catch_phrase)
                
                skills = test_user.skills.build(
                :name => Faker::Hacker.ingverb,
                :description => Faker::Hacker.say_something_smart,
                :skill_type_id => skilltype.id,
                :level => "Beginners",
                :required_experience => Faker::Lorem.characters(10),
                :start_date => rand(1.year).from_now,
                :max_students => Faker::Number.number(2),
                :min_students => Faker::Number.digit,
                :price => Faker::Number.digit,
                :user_id => test_user.id,
                :location_id => test_user.location.id,
                :activity_duration => Faker::Number.digit,
                :teachers_title => Faker::Name.title)
                # location.save

                skills.save

                slocation = skills.build_location(:address => location.street_address,
                :street_address => location.street_address,
                :postcode => location.postcode,
                :latitude => location.latitude,
                :longitude => location.longitude,
                :google_address => location.street_address,
                :city => location.city,
                :locality => location.locality)
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