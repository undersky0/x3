class InvitationsController < ApplicationController
  #respond_to :html
  
  def invited_params
    invited_params[:user_id]
  end
  
  def inviteable_params
    inviteable_params[:group_id]
  end
  
  
   def sendinv
     # invited_params[:user_id]=invited_params[:user_id].select{|r| !r.blank?}
     # @invited = invited_params.merge
     @invited = User.find_by_id(params[:user_id])
     
     if params[:c] == "Group"
     @inviteable = Group.find_by_id(params[:group_id])
    else 
     @inviteable = Skill.find_by_id(params[:skill_id])
     end
       
    
    
    unless @invited.nil? or @inviteable.nil?
       if Invitation.send_invite(@inviteable, @invited)
        flash[:notice] = "Invite sent"
      redirect_to :back      
      else
        flash[:notice] = "Invite could not be sent"
      redirect_to :back   
    end
      end
end

def cancel_inv
       @invited = User.find_by_id(params[:user_id])
     
     if params[:c] == "Group"
     @inviteable = Group.find_by_id(params[:group_id])
    else
     @inviteable = Skill.find_by_id(params[:skill_id])
     
     end
       
    
    
    unless @invited.nil? or @inviteable.nil?
       if Invitation.cancel_invite(@inviteable, @invited)
        flash[:notice] = "Invite canceled"
      #redirect_to :back
      else
        flash[:notice] = "Invite could not be canceled"
      respond_with @inviteable
    end
      end
end
    
   def accept
    @invited = current_user
    @inviteable = Group.find_by_id(params[:id])
    unless @inviteable.nil?
      if Invitation.accept_invite(@inviteable, @invited)
        flash[:notice] = "Invite accepted"
      else
        flash[:notice] = "Invite error"
      end
      
    end
    redirect_to :back
  end
  
   def reject
    @invited = current_user
    @inviteable = Group.find_by_id(params[:id])
    unless @inviteable.nil?
      if Invitation.reject_invite(@inviteable, @invited)
        flash[:notice] = "Invite was declined"
      else
        flash[:notice] = "Unable to decline"
      end
    end
    redirect_to :back
  end
      
  
  
  
  
  def index
    @invitations = Invitation.all
    @users = User.all
    @group = Group.last
    @skill = Skill.last
  @inviteable = @skill
    
    #people from the same city as the skill
    if params[:location].present?
    @users1 = Location.users_city(params[:location])
    @localusers = User.find([@user1])
    else
      @l = @skill.location
      @users1 = Location.users_city(@l)
      @localusers = User.find([@users1])
    end
    
    #show people from city, friendlist, city as skill/group
   
  end

  def show
    @user = current_user
    @user.friends
    @invitation = Invitation.find(params[:id])
  end

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    if @invitation.save
      redirect_to @invitation, :notice => "Successfully created invitation."
    else
      render :action => 'new'
    end
  end

  def edit
    @invitation = Invitation.find(params[:id])
  end

  def update
    @invitation = Invitation.find(params[:id])
    if @invitation.update_attributes(params[:invitation])
      redirect_to @invitation, :notice  => "Successfully updated invitation."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    redirect_to invitations_url, :notice => "Successfully destroyed invitation."
  end
end
