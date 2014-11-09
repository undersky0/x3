class FriendshipsController < ApplicationController
  respond_to :js
  
  def request_fr
    @user = current_user
    @friend = User.find_by_id(params[:id])

    if !@friend.nil?
       Friendship.request(@user, @friend)
      else
        flash[:notice] = "friend request could not be sent"
        redirect_to :back
      end
      flash[:notice] = 'hey'
      
    rescue PG::UniqueViolation => error
    flash[:notice] << error.message
    false
  end
  
  def accept
    @user = current_user
    @friend = User.find_by_id(params[:id])
    unless @friend.nil?
    Friendship.accepted(@user, @friend)
        flash[:notice] = "friendship accepted"
    end
  end
  
  def reject
    @user = current_user
    @friend = User.find_by_id(params[:id])
    unless @friend.nil?
    Friendship.reject(@user, @friend)
        flash[:notice] = "friend request rejected"
      end
  end
end
