class LandingPageController < ApplicationController
  def index
    @location = Location.new
  end
end
