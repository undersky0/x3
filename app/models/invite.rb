class Invite < ActiveRecord::Base
  attr_accessible :user_id, :inviteable_id, :inviteable_type, :status, :token, :sent_at
  scope :joined, -> { where(status: "Joined")}
  
  belongs_to :inviteable, :polymorphic => true
  belongs_to :user

    def self.send_invite(user, inviteable)
    f1 = self.new(:user_id => user.id, :inviteable_id => inviteable.id, :inviteable_type => inviteable.class.base_class.name, :status => "Invited", :sent_at => Time.now)
    f1.save
   end
   
   def self.addwatchlist(user, inviteable)
    f1 = self.new(:user_id => user.id, :inviteable_id => inviteable.id, :inviteable_type => inviteable.class.base_class.name, :status => "Watched", :sent_at => Time.now)
      f1.save
      return f1
   end
      
   def self.removewatchlist(invite)
      self.destroy(invite)
   end
   
   def self.join(user, inviteable)
    f1 = self.new(:user_id => user.id, :inviteable_id => inviteable.id, :inviteable_type => inviteable.class.base_class.name, :status => "Joined", :sent_at => Time.now)
      f1.save
      return f1
   end
   
   def self.leave(invite)
    self.destroy(invite)
   end
   
   def self.accept_invite(invite)
     f1 = self.find(invite)
     f1.update_attributes(:status => "Accepted")
   end
  
  def self.reject_invite(invite)
    self.destroy(invite)
  end
end
