class ArealistCell < Cell::Rails
include Devise::Controllers::Helpers


    helper_method :current_user
  def show
    @user = current_user
    @location = @user.location.city
    @localfeeds = Localfeed.where(city: @location).map(&:locality)
    #@localfeeds = Localfeed.all
    render
  end
end
