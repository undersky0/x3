class RegistrationsController < Devise::RegistrationsController
  
  layout "devise"
    def build_resource(*args)
    super
      if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end

  def create
    super
    session[:omniauth] = nil unless @user.new_record?

  end
  
  def after_sign_up_path_for(resource)
    new_user_profile_path(current_user)
  end
end
