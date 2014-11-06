class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.json
  #before_filter :load_mappable
  skip_before_filter :redirect_invalid_locations, only: [:new, :create]
  skip_filter :ensure_signup_complete
  def index
  @locations = Location.all
  @user = current_user
  @geojson = Array.new
  @locations.each do |location|
    @geojson << {
      type: 'feature',
      geometry: {
        type: 'point',
        cooardinates: [location.longitude, location.latitude]
      },
      properties: {
        name: location.address,
        address: location.address,
        :'marker-color' => '#00607d',
        :'marker-symbol' => 'circle',
        :'marker-size' => 'medium'
      }
    }
  end
  @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
  marker.lat location.latitude
  marker.lng location.longitude
  end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    @user = current_user
    @user.build_location
    @context = context
    @location = @context.build_location
    #@location = Location.new
    gon.user = current_user
  end

  # GET /locations/1/edit
  def edit
    @context = context
    @location = @context.location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    @context = context
    @location = @context.build_location(params[:location])
    @user = current_user
    #@mappable = load_mappable
    respond_to do |format|
    if @location.save     
      format.html { redirect_to @context, notice: " Created"}
      #format.json { render :json => :back, :status => :created, :location => @user }
      #redirect_to @commentable, notice: "Comment created."
    else
      format.html { redirect_to @location }
      format.json { render :json => @location.errors, :status => :unprocessable_entity }
      #render :new
    end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    @context = context
    @location = @context.location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end
private 
  def context
    if params[:user_id]
      id = params[:user_id]
      User.find(params[:user_id])
    elsif params[:skill_id]
      id = params[:skill_id]
      Skill.find(params[:skill_id])
    else
      id = params[:group_id]
      Group.find(params[:group_id])
    end
  end 

  def context_url(context)
    if User === context
      user_path(context)
    elsif Skill === context
      skill_path(context)
    else
      group_path(context)
    end
  end
  
  
      
  # def load_mappable
    # resource, id = request.path.split('/')[1,2]
    # @mappable = resource.singularize.classify.constantize.find(id)
  # end
    
    
end
