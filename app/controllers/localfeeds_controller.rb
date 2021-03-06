class LocalfeedsController < ApplicationController
  before_filter :loadscribbles
  before_filter :set_localfeed, only: [:edit, :update, :destroy]
  def index
    @location = current_user.location.city
    @cities = Localfeed.select(:id, :locality, :city).order('city ASC')
    @localfeeds = @cities.group_by {|k| k[:city] }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @localfeeds }
    end
  end


  def show
    @cities = Localfeed.select(:id, :locality, :city).order('city ASC')
    @localfeeds = @cities.group_by {|k| k[:city] }
    if params[:id].present?
      @localfeed = Localfeed.find(params[:id])
    else
      @localfeed = Localfeed.find_by_location_id(current_user.location.id)
    end
    @scribbles = @localfeed.scribbles.order("created_at DESC").page params[:page]
    @scribbled = @localfeed
      respond_to do |format|
      format.js
      format.html
      format.json { render :json => @localscribbles }
    end
  end

  def new
    @localfeed = Localfeed.new
    @feed = Localfeed.find_by_id(params[:localfeed])
  end

  def create
    @localfeed = Localfeed.new(params[:localfeed])
    if @localfeed.save
      redirect_to @localfeed, :notice => "Successfully created localfeed."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @localfeed.update_attributes(params[:localfeed])
      redirect_to @localfeed, :notice  => "Successfully updated localfeed."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @localfeed.destroy
    redirect_to localfeeds_url, :notice => "Successfully destroyed localfeed."
  end
  
  def loadscribbles
    if params[:localfeed_id]
      @localfeed = Localfeed.find(params[:localfeed_id])
    end
  end
  
  def newlocalscribble
    @localfeed = Localfeed.find(params[:id])
    @user = current_user
    @newlocalscribble = @localfeed.scribbles.create(params[:scribble])
    redirect_to @localfeed
  end
  
  def useraddress
    if current_user.location.nil?
      redirect_to new_user_locations_path(current_user.id)
    end
  end
  
  private
  
  def set_localfeed
    @localfeed = Localfeed.find(params[:id])
  end
end
