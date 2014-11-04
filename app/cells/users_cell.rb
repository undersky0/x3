class UsersCell < Cell::Rails
include Devise::Controllers::Helpers
    helper_method :current_user
  def show
    @user = current_user
    @userfriends = @user.pending_friends.take(5)
    @useroldfriends = @user.friends.last(5)
    render
  end

end
