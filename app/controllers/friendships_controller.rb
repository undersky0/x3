class FriendshipsController < ApplicationController
  respond_to :js
  before_action :set_friend
  def request_fr
    if !@friend.nil?
       Friendship.request(@user, @friend)
      else
        flash[:notice] = "friend request could not be sent"
        redirect_to :back
      end    
    rescue PG::UniqueViolation => error
    flash[:notice] << error.message
    false
  end
  
  def accept
    unless @friend.nil?
    Friendship.accepted(@user, @friend)
        flash[:notice] = "friendship accepted"
    end
  end
  
  def reject
    unless @friend.nil?
    Friendship.reject(@user, @friend)
        flash[:notice] = "friend request rejected"
      end
  end
  
  def set_friend
    @user = current_user
    @friend = User.find_by_id(params[:id])
  end
end
