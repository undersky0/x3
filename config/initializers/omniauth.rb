OmniAuth.config.logger = Rails.logger

# Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :facebook, '175988805944789', '37cffa69bccaae14344b61637ea3971f',
  # :scope => 'email,user_birthday,read_stream, user_about_me, user_events,
  # user_education_history, friends_education_history, friends_events,
  # user_hometown, friends_hometown, user_interests, friends_interests,
  # user_location, friends_location, user_relationships, friends_relationships,
  # user_website, user_work_history', :secure_image_url => true
#   
# end 

# Rails.application.config.middleware.use OmniAuth::Builder do
  # # The following is for facebook
  # provider :facebook, '175988805944789', '37cffa69bccaae14344b61637ea3971f', {:scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
#  
  # # If you want to also configure for additional login services, they would be configured here.
# end