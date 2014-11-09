class Invitation < ActiveRecord::Base
  attr_accessible :invited_id, :invited_type, :inviteable_id, :inviteable_type, :sent_at, :status
  
  belongs_to :inviteable, :polymorphic => true
  belongs_to :invited, :polymorphic => true
  
  scope :invited_groups, lambda {where(["invited_id = ? AND invited_type = ? AND inviteable_type = 'group'", invited.id, invited.class.base_class.name]) }
  scope :for_voteable, lambda { |*args| where(["voteable_id = ? AND voteable_type = ?", args.first.id, args.first.class.base_class.name]) }
  scope :recent, lambda { |*args| where(["created_at > ?", (args.first || 2.weeks.ago)]) }
  scope :descending, lambda { order("created_at DESC") }

  #invite has_many many users
  #belongs_to inviteable, :polymorphic => true
  
  #user has_many invites
  #group has_many invites, as: :inviteable  
  #scope groups_invites returns all of the invites that a group has made
  #scope :group_invites_sent, lambda {where(["inviteable_id = ? AND inviteable_type = 'Group' AND status = 'Sent'", inviteable.id])}
  #scope groups_invites_sent
  #scope groups_invites_accepted
  #scope group_invites_rejected
  
  #scope user_invites returns all of the invites that a particular user has
  #scope users_invites_sent
  #scope users_invites_accepted
  #scope users_invites_rejected
  
    def self.group_invites_sent(inviteable)
      self.where(:inviteable_id => inviteable.id, :inviteable_type => 'Group', :status => 'Sent').order("created_at DESC")
    end
    
    def self.group_invites_accepted(inviteable)
      self.where(:inviteable_id => inviteable.id, :inviteable_type => 'Group', :status => 'Accepted').order("created_at DESC")
    end
    
    def self.group_invites_accepted(inviteable)
      self.where(:inviteable_id => inviteable.id, :inviteable_type => 'Group', :status => 'Rejected').order("created_at DESC")
    end
  
    def self.user_invites(invited)
    self.where(:invited_id => invited.id, :invited_type => 'User', :status => 'Sent').order("created_at DESC")
    end
    def self.user_invites_accepted(invited)
    self.where(:invited_id => invited.id, :invited_type => 'User', :status => 'Accepted').order("created_at DESC")
    end
    def self.user_invites_declined(invited)
    self.where(:invited_id => invited.id, :invited_type => 'User', :status => 'Declined').order("created_at DESC")
    end
    
    def self.been_sent(inviteable,invited)
      return true unless find_by_inviteable_id_and_inviteable_type_and_invited_id_and_invited_type_and_status(
            inviteable.id,
            inviteable.class.base_class.name,
            invited.id, 
            invited.class.base_class.name, 
            'Sent').nil?
            false
    end
  
  #scope :aleardy_invited?, lambda {where(["invited_id = AND invited_type = ? AND inviteable_type"])}
  # def self.are_invited(inviteable, invited)
    # return false if inviteable == invited
    # return true unless find_by_invitable
  # end
# 
  def self.send_invite(inviteable, invited)
    # if inviteable.nil? or invited.nil?
      # return false
    # else
    i = self.new(:inviteable_id => inviteable.id, 
                :inviteable_type => inviteable.class.base_class.name, 
                :invited_id => invited.id, 
                :invited_type => invited.class.base_class.name, 
                :status => "Sent", :sent_at => Time.now)
    i.save    
        # end
        #return true       
  end
  
  #update status to accepted
  #create 
  def self.accept_invite(inviteable, invited)
    i = self.find_by_inviteable_id_and_inviteable_type_and_invited_id_and_invited_type(inviteable.id, inviteable.class.base_class.name, invited.id,invited.class.base_class.name)
    # i = self.where(:inviteable_id => inviteable.id,
                   # :inviteable_type => inviteable.class.base_class.name,
                   # :invited_id => invited.id,
                   # :invited_type => invited.class.base_class.name)
    if i.nil?
      return false
    else
      i.update_attributes(:status => "Accepted")
    end
    return true
  end  
  
  def self.reject_invite(inviteable, invited)
    
    i = Invitation.find_by_inviteable_id_and_inviteable_type_and_invited_id_and_invited_type(inviteable.id, inviteable.class.base_class.name, invited.id,invited.class.base_class.name)
    # i = self.where(:inviteable_id => inviteable.id,
                   # :inviteable_type => inviteable.class.base_class.name,
                   # :invited_id => invited.id,
                   # :invited_type => invited.class.base_class.name)
    if i.nil?
      return false
    else
      i.update_attributes(:status => "Declined")
    end
    return true
  end

  def self.cancel_invite(inviteable, invited)
      i = Invitation.find_by_inviteable_id_and_inviteable_type_and_invited_id_and_invited_type_and_status(inviteable.id, inviteable.class.base_class.name, invited.id, invited.class.base_class.name, :status => "sent")

    if i.nil?
      return false
    else
      i.destroy
    end
    return true
    end
end
