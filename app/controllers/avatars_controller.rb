class AvatarsController < ApplicationController
  
  before_filter :load_avatarable
  before_action :set_avatar, only: [:destroy,:update,:edit,:show]
  
  def index
    @avatars = Avatar.all
  end

  def show
    @user = current_user
  end

  def new
    @avatar = Avatar.new
    @avatarable = load_avatarable
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @avatar }
    end
  end

  def create
    @avatarable = load_avatarable
    @avatar = Avatar.new(params[:avatar])

    respond_to do |format| 
    if @avatar.save 
      @avatarable.avatar = @avatar
      format.html { redirect_to @avatarable, notice: 'Photo was successfully created.' } 
      format.json { data = {id: @avatar.id, thumb: view_context.image_tag(@avatar.photo.url(:thumb))} 
      render json: data, status: :created, location: @avatar } 
      else format.html { render action: "new" } 
           format.json { render json: @avatar.errors, status: :unprocessable_entity } 
           end 
      end
  end

  def edit
  end

  def update
    if @avatar.update_attributes(params[:avatar])
      redirect_to :back
    else
      render :action => 'edit'
    end
  end

  def destroy
    @avatar.destroy
    redirect_to avatars_url, :notice => "Successfully destroyed avatar."
  end
  
  def set_avatar
    @avatar = Avatar.find(params[:id])
  end
  
  private 
  def load_avatarable
    resource, id = request.path.split('/')[1,2]
    @avatarable = resource.singularize.classify.constantize.find(id)
end
end
