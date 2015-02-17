require 'rails_helper'
require 'spec_helper'
RSpec.describe Friendship, :type => :model do
  it { should belong_to(:user)}
  it { should belong_to(:friend).class_name("User").with_foreign_key('friend_id')}
  it { should validate_presence_of(:user_id)}
  it { should validate_presence_of(:friend_id)}
  
  before(:each) do
  @user = FactoryGirl.create(:user)
  @friend = FactoryGirl.create(:user)
  end
  
  it "are friends returns false" do
    expect(Friendship.are_friends(@user,@friend)).to be  false
  end
  
  it "are friends return true" do 
    f1 = create(:friendship, user_id: @user.id, friend_id: @friend.id)
    f2 = create(:friendship, user_id: @friend.id, friend_id: @user.id)
    expect(Friendship.are_friends(@user,@friend)).to be true
  end
end
