class ProfilesController < ApplicationController
  skip_filter :redirect_invalid_locations, :only => [:new, :create]
  skip_filter :ensure_signup_complete
  layout "about", :only => :new
  before_filter :set_profile, :only => [:edit, :destroy, :update]
  before_filter :set_userprofile, :only => [:index, :show, :namereg]
  def index
    @profiles = Profile.all
    if params[:query].present?
      @user = Profile.search(params[:query])
    else
      @use = Profile.all
      @user = Kaminari.paginate_array(@use).page(params[:page]).per(5)
    end
  end

  def show
    @user = User.find_by_id(params[:user_id])
    @profile = @user.profile
  end

  def new
    @user = current_user
    @profile = @user.build_profile
  end

  def create
    @user = current_user
    @profile = @user.build_profile(params[:profile])
    if @profile.save
      redirect_to new_user_locations_path(current_user), :notice => "Successfully created profile."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @profile.update_attributes(params[:profile])
      redirect_to @profile, :notice  => "Successfully updated profile."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @profile.destroy
    redirect_to profiles_url, :notice => "Successfully destroyed profile."
  end
  
  def namereg
    if @profile.update_attributes(profile_params)
      redirect_to @profile, :notice  => "Successfully updated profile."
    else
      render :action => 'edit'
    end
  end
  
  def set_profile
    @profile = Profile.find(params[:id])
  end
  def set_userprofile
    @profile = current_user.profile
  end
end
