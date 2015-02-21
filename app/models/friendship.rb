class Friendship < ActiveRecord::Base
  attr_accessible :user_id, :friend_id, :status
  belongs_to :user
  belongs_to :friend, :class_name => "User", :foreign_key => 'friend_id'
  #has_many :notifications, foreign_key: :notified_object_id, conditions: {notified_object_type: 'Friendship'}, dependent: :destroy
  validates_presence_of :friend_id, :user_id
  #http://blog.meldium.com/home/2013/4/22/dont-spam-your-users-batch-notifications-in-rails  for notifications scheduale
  
  def self.accepted_friend_notification(user, friend)
    @user = User.find_by_id(user)
    @friend = User.find_by_id(friend)
    subject = "#{@user.name}"
    body = "#{@user.name} Has accepted your friednship request"
    #@friend.notify(subject, body, @user)
  end
  
  def self.request_friend_notification(user, friend)
    @friend = User.find_by_id(friend)
    @user = User.find_by_id(user)
    subject = "#{@user.name}"
    body = "#{@user.name} Sent you a friend request"
    #@friend.notify(subject, body)
  end
  
  def self.are_friends(user, friend)
    return false if user == friend
    return true unless find_by_user_id_and_friend_id_and_status(user, friend, "accepted").nil?
    return true unless find_by_user_id_and_friend_id_and_status(friend, user, "accepted").nil?
    false
  end
  
  def self.are_friends_pending(user, friend)
    return false if user == friend
    return true unless find_by_user_id_and_friend_id_and_status(user, friend, "pending").nil?
    return true unless find_by_user_id_and_friend_id_and_status(friend, user, "requested").nil?
    false
  end
  
  def self.request(user, friend)
    return false if are_friends(user, friend)
    return false if user == friend
    f1 = self.new(:user_id => user.id, :friend_id => friend.id, :status => "pending")
    f2 = self.new(:user_id => friend.id, :friend_id => user.id, :status => "requested")
    transaction do
      f1.save
      f2.save
    end
    #request_friend_notification(user,friend)
  end
  
  def self.accepted(user, friend)
    f1 = find_by_user_id_and_friend_id(user.id, friend.id)
    f2 = find_by_user_id_and_friend_id(friend.id, user.id)
    if f1.nil? or f2.nil?
      return false
    else
      transaction do
        f1.update_attributes(:status => "accepted")
        f2.update_attributes(:status => "accepted")
        
      end 
      #accepted_friend_notification(user,friend)
    end
    return true
  end
  
  def self.reject(user,friend)
    f1 = find_by_user_id_and_friend_id(user.id, friend.id)
    f2 = find_by_user_id_and_friend_id(friend.id, user.id)
    if f1.nil? or f2.nil?
      return false
    else
      transaction do
        f1.destroy
        f2.destroy
        return true
        
      end
    end
  end
  
  
end