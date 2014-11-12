FactoryGirl.define do
  factory :skill do
      name {Faker::Hacker.ingverb}
      description {Faker::Hacker.say_something_smart}
      skill_type_id '1'
      level "Beginners"
      required_experience {Faker::Lorem.characters(10)}
      start_date {Faker::Date.forward(23)}
      max_students '10'
      min_students '2'
      price {Faker::Number.digit}
      user_id '1'
      location_id '1'
      activity_duration {Faker::Number.digit}
      teachers_title {Faker::Name.title}
  end
  
  factory :invalid_skill do
      name nil
      description {Faker::Hacker.say_something_smart}
      skill_type_id '1'
      level "Beginners"
      required_experience {Faker::Lorem.characters(10)}
      start_date {Faker::Date.forward(23)}
      max_students '10'
      min_students '2'
      price {Faker::Number.digit}
      user_id '1'
      location_id '1'
      activity_duration {Faker::Number.digit}
      teachers_title {Faker::Name.title}
  end

end
