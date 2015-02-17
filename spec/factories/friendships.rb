FactoryGirl.define do
  factory :friendship, class: Friendship do
    user_id '1'
    friend_id '2'
    status "accepted"
  end
  factory :friendship2, class: Friendship do
    user_id '2'
    friend_id '1'
    status "accepted"
  end

end
