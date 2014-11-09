class GroupsController < ApplicationController
  before_filter :loadscribbles
  respond_to :json
  respond_to :html, :js
  def autocomplete
    render json: Groop.search(params[:query], autocomplete: true, limit: 10).map(&:name)
  end
  
  
  def index

    if params[:query].present? && params[:location].blank?
      @groups = Group.search(params[:query])
      #@location = current_user.location.city
     # @user = Kamari.paginate_array(@use).page(params[:page]).per(5)
     elsif params[:query].blank? && params[:location].present? 
       @distance = 20
       @location = Location.near(params[:location], @distance, :order => 'distance').where(:user_id => nil).map(&:group_id)
       @l = Group.find([@location])
       @groups = Kaminari.paginate_array(@l).page(params[:page]).per(5)
    elsif params[:query].present? && params[:location].present?
      @location = Location.near(params[:location], 20, :order => 'distance').where(:user_id => nil).map(&:group_id)
      @grouplocation = Kaminari.paginate_array(@location).page(params[:page]).per(5)
      @group = Group.search(params[:query]).map(&:id)
      @x = @group + @location
      @g = Group.find([@x.uniq])
      @groups = Kaminari.paginate_array(@g).page(params[:page]).per(10)
    else
      @current_location = current_user.location.city
      @location =Location.near(@current_location, @distance, :order => 'distance').where(:user_id => nil)
      @groups = Kaminari.paginate_array(@location).page(params[:page]).per(10)
    end
          
  end

  def show

    @group = Group.find(params[:id])
    @groupscribbles = Scribble.where(:scribbled_id => @group, :scribbled_type => "Group")
    @scribbled = @group
    @scribbles = @scribbled.scribbles.order("created_at DESC").page params[:page]
    @scribble = Scribble.new
    @albumable = @group
    @albums = @albumable.albums
    @album = Album.new
    @users = User.all
    @avatarable = @group
    if params[:query].present?
      @profiles = Profile.search(params[:query])
     # @user = Kamari.paginate_array(@use).page(params[:page]).per(5)
    else
      @use = Profile.all
      @profiles = Kaminari.paginate_array(@use).page(params[:page]).per(5)
          end
  end

  def new
    @group = Group.new
    @group.build_location
  end

  def create
    @group = current_user.groups.build(params[:group])
    if @group.save
    respond_to do |format|  
      #format.html {redirect_to group_path(@group), :notice => "Successfully created new group." }
      format.html { redirect_to @group, notice: 'Group was successfully created.' }
      format.js   { render action: 'show', status: :created, location: @group }
    end
    else
      render :action => 'new'
    end
    
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params[:group])
      redirect_to @group, :notice  => "Successfully updated group."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_url, :notice => "Successfully destroyed group."
  end
  
   def newgroupscribble
    @group = Group.find(params[:id])
    @user = current_user
    @newgroupscribble = @group.scribbles.create(params[:scribble])
    redirect_to @group
  end
  
    def loadscribbles
    if params[:group_id]
      @group = Group.find(params[:group_id])
    end
  end

end
