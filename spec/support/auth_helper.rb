module AuthHelper
  def http_login
    user = 'test@test.com'
    pw = 'password'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end
  
  def current_user
    user_session_info = response.request.env["rack.session"]["warden.user.user.key"]
    if user_session_info
      user_id = user_session_info[0][0]
      User.find(user_id)
    else
      nil
    end
  end
  
  def user_signed_in?
    !!current_user
  end
    def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryGirl.create(:user)
      user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in user
    end
  end
  
end