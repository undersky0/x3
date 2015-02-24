class InvitesController < ApplicationController
respond_to :js
  
  def invite
    @user = User.find_by_id(params[:user_id])
    @inviteable = inviteable
    @invite = inviteable
      unless @user.nil? || @inviteable.nil?
        @invite = Invite.send_invite(@user, @inviteable)
      else
        flash[:notice] = "invite could not be sent"
    end
  end

  def join
    #should be redirecting to payment page for skills
  @user = User.find_by_id(params[:user_id])
  @inviteable = inviteable 
    unless @user.nil? || @inviteable.nil?
     @invite = Invite.join(@user, @inviteable)
    else
      flash[:notice] = "something went wrong, try again"
    end
  end

  def leave
    #should be redirecting to leaving page for skils
    @invites = Invite.find(params[:id])
    @invite = invitetype
    @user = current_user
    unless @invites.nil?
      Invite.leave(@invites)
    else
      flas[:notice] = "something went wrong, try again"
    end
  end

  def addwatch
    @user = User.find_by_id(params[:user_id])
    @inviteable = inviteable 
      unless @user.nil? || @inviteable.nil?
       @invite = Invite.addwatchlist(@user, @inviteable)
      else
        flash[:notice] = "something went wrong, try again"
    end
  end

  def removewatch   
    @invites = Invite.find(params[:id])
    @invite = invitetype
    @user = current_user
    if @invites.nil?
      flas[:notice] = "something went wrong, try again"
    else
      puts @invites.inspect
      Invite.removewatchlist(@invites)
      flash[:notice] = "Removed"
    end
  end


private
  def invitetype
   if @invites.inviteable_type == "Skill"
      @invite = Skill.find(@invites.inviteable_id)
    else
      @invite = Group.find(@invites.inviteable_id)
    end
  end

  def inviteable
    if params[:inviteable_type] == "Group"
      id = params[:inviteable_id]
      Group.find(params[:inviteable_id])
    else
      id = params[:inviteable_id]
      Skill.find(params[:inviteable_id])
    end
  end 
end