class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :redirect_invalid_locations
  #before_filter :authenticate_user!
  include ApplicationHelper
  helper_method :recipients
  before_filter :ensure_signup_complete, only: [:new, :create, :update, :destroy]


   def recipients
    curr_u = current_user
    User.all.reject { |u| u.id == curr_u.id }.compact
  end
  
  
  private
  def redirect_invalid_locations
    unless current_user.nil?
    redirect_to(new_user_locations_path(current_user.id)) if invalid_location?
    end
  end

  def invalid_location?
    current_user.try(:location).try(:city).nil?
  end
  
  
  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'
    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end
  
end