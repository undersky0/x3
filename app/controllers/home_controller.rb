class HomeController < ApplicationController
  skip_filter :authenticate_user!
  skip_filter :redirect_invalid_locations
  layout "about"
  def index
    
  end

  def aboutme

  end

  def undersky_project

  end
end
