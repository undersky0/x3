FactoryGirl.define do
  factory :location do
    street_address {Faker::Address.street_name}
    address {Faker::Address.street_name}
    google_address {Faker::Address.street_name}
    city {Faker::Address.city}
    latitude {Faker::Address.latitude}
    longitude {Faker::Address.longitude}
    postcode "CF11 6LL"
    # after(:create) { |l| get_ward(l) }
    end
end
