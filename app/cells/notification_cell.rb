class NotificationCell < Cell::Rails
include Devise::Controllers::Helpers
    helper_method :current_user
  def show
    @user = current_user
    @notification = @user.mailbox.notifications.first(5)
    render
  end
end
