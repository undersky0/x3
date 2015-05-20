FactoryGirl.define do
  factory :blog_post do
    author_name "MyString"
    title "MyString"
    content {Faker::Lorem.sentence(3, true)}
    keywords "green"
  end

end
