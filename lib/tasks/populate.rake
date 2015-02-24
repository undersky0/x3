namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'faker'
  # Faker::Config.locale = :engb
     #Rake::Task['db:reset'].invoke
     

                displayName = Faker::Name.name
                email = "test-#{Faker::number.number(100)}@tests.org"
                password = "password"
                test_user = User.create!(
                  :email => email,
                  :password => password,
                  :password_confirmation => password) 
                
                test_user.build_profile(
                firstname: Faker::Name.first_name,
                lastname: Faker::Name.last_name,
                website: Faker::Internet.url,
                phoneNo: Faker::PhoneNumber.phone_number,
                about: Faker::Lorem.sentence(6),
                skills: Faker::Lorem.words(3),
                interests: Faker::Lorem.words(3),
                university:Faker::Lorem.words(3),
                college:Faker::Lorem.words(3),
                school:Faker::Lorem.words(3), 
                )
                  
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
                skilltype = SkillType.create(:name => Faker::Commerce.department,
                :description => Faker::Company.catch_phrase)
                
                skills = test_user.skills.build(
                Faker::Company.bs,
                Faker::Lorem.sentence(3),
                :skill_type_id => skilltype.id,
                :level => "Beginners",
                :required_experience => Faker::Lorem.sentences(1),
                :start_date => rand(1.year).from_now,
                :max_students => Faker::Number.number(2),
                :min_students => 1,
                :price => Faker::Number.digit,
                :user_id => test_user.id,
                :location_id => test_user.location.id,
                :activity_duration => Faker::Number.digit,
                :teachers_title => Faker::Name.title)
                # location.save
                skills.build_location
                skills.location = location
                skills.save

                

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