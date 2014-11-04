class MessageCell < Cell::Rails

include Devise::Controllers::Helpers


    helper_method :current_user

  def show
    @inbox = current_user.mailbox.inbox.first(5)
    render
  end
end
