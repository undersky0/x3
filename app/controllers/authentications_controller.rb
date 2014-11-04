class AuthenticationsController < ApplicationController
  skip_before_filter :authenticate_user!
  def index
    @authentications = current_user.authentications.all
  end
  
  def home
  end
  
  def twitter
     omni = request.env["omniauth.auth"]
     authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid'])

     if authentication
       flash[:notice] = "Logged in Successfully"
       sign_in_and_redirect edit_user_profile_path(current_user.id)    
     elsif current_user
       token = omni['credentials'].token
       token_secret = omni['credentials'].secret

       current_user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)
       flash[:notice] = "Authentication successful."
       sign_in_and_redirect edit_user_profiles(current_user.id)    
     else
       user = User.new 
       user.apply_omniauth(omni)

       if user.save
         flash[:notice] = "Logged in."
         sign_in_and_redirect namereg_user_profile_path(current_user.id)      
       else
         session[:omniauth] = omni.except('extra')
         redirect_to new_user_registration_path
       end
     end 
   end
   
   def destroy
     @authentication = Authentication.find(params[:id])
     @authentication.destroy
     redirect_to authentications_url, :notice => "Successfully destroyed authentication."
   end
   
   
   def facebook
     omni = request.env["omniauth.auth"]
     authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid'])

     if authentication
       flash[:notice] = "Logged in Successfully"
       sign_in_and_redirect User.find(authentication.user_id)
     elsif current_user
       token = omni['credentials'].token
       token_secret = ""

       current_user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)

       flash[:notice] = "Authentication successful."
       sign_in_and_redirect current_user
     else
       user = User.new
       user.build_profile
       user.build_location
       user.build_useravatar
       user.email = omni['extra']['raw_info'].email 
       user.profile.firstname = omni['extra']['raw_info'].first_name
       user.profile.lastname =  omni['extra']['raw_info'].last_name
       user.profile.age = omni['extra']['raw_info'].birthday
       user.location.address = omni['extra']['raw_info'].location
       #if env["omniauth.auth"]["info"].present?
        avatar_url = process_uri(env["omniauth.auth"]["info"]["image"])
   user.useravatar.attachment = URI.parse(avatar_url)
#end
       
       #user.avatar_remote_url = env["omniauth.auth"]["info"]["image"]
       user.apply_omniauth(omni)

       if user.save
         flash[:notice] = "Logged in."
         sign_in_and_redirect User.find(user.id)             
       else
         
         session[:omniauth] = omni.except('extra')
         redirect_to new_user_registration_path
       end
     end
   end
   
     def failure
redirect_to new_user_registration_path, :flash => {:error => "Could not log you in. #{params[:message]}"}
end
   
   private

  def process_uri(uri)
    require 'open-uri'
    require 'open_uri_redirections'
    open(uri, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end
  end
end