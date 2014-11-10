FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "12345678a"
    password_confirmation "12345678a"
    end
end
