class Invite < ActiveRecord::Base
  attr_accessible :user_id, :inviteable_id, :inviteable_type, :status, :token, :sent_at
  scope :joined, -> { where(status: "Joined")}
  
  belongs_to :inviteable, :polymorphic => true
  belongs_to :user

    def self.send_invite(user, inviteable)
    f1 = self.new(:user_id => user.id, :inviteable_id => inviteable.id, :inviteable_type => inviteable.class.base_class.name, :status => "Invited", :sent_at => Time.now)
    transaction do
      f1.save
    end
   end
   
   def self.addwatchlist(user, inviteable)
    f1 = self.new(:user_id => user.id, :inviteable_id => inviteable.id, :inviteable_type => inviteable.class.base_class.name, :status => "Watched", :sent_at => Time.now)
      f1.save
      return f1
   end
      
   def self.removewatchlist(invite)
    f1 = self.where(id: invite, status: "Watched")
    transaction do
      f1.destroy
    end
   end
   
   def self.join(user, inviteable)
    f1 = self.new(:user_id => user.id, :inviteable_id => inviteable.id, :inviteable_type => inviteable.class.base_class.name, :status => "Joined", :sent_at => Time.now)
      f1.save
      return f1
   end
   
   def self.leave(invite)
    f1 = self.find(invite, status: "Joined")
    transaction do
      f1.destroy
    end
   end
   
   def self.accept_invite(invite)
     f1 = self.find(invite)
     transaction do
     f1.update_attributes(:status => "Accepted")
    end
   end
  
  def self.reject_invite(invite)
    f1 = self.find(invite)
    transaction do
      f1.destroy
    end
  end
  
 
  
end
