namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'faker'

    # Rake::Task['db:reset'].invoke

10.times do |n|
      displayName = Faker::Name.name
      email = "test-#{n+299}@test1ssss.org"
      password = "password"
      test_user = User.create!(
        :email => email,
        :password => password,
        :password_confirmation => password) 
     
        profile = test_user.build_profile(:firstname => Faker::Name.name,
          :lastname => Faker::Name.name)
          profile.save
          
             location = test_user.build_location(:address => Faker::Address.street_name,
                :postcode => Faker::Address.postcode,
                :city => Faker::Address.city)

                puts location.address
                
                skilltype = SkillType.create(:name => Faker::Lorem.words(2),
                :description => Faker::Lorem.sentence(3))
                
                
                skills = test_user.skills.build(
                :name => Faker::Lorem.characters(10),
                :description => Faker::Lorem.characters(10),
                :skill_type_id => skilltype.id,
                :level => "Beginners",
                :required_experience => Faker::Lorem.characters(10),
                :start_date => rand(1.year).from_now,
                :max_students => n,
                :min_students => Faker::Number.digit,
                :price => Faker::Number.digit,
                :user_id => test_user.id,
                :location_id => location.id,
                :activity_duration => Faker::Number.digit,
                :teachers_title => Faker::Lorem.characters(10))
                location.save
                test_user.build_useravatar
                test_user.save
                skills.save
                
end                
end
end