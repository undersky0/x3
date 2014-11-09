class AvatarsController < ApplicationController
  
  before_filter :load_avatarable
  
  def index
    @avatars = Avatar.all
  end

  def show
    @avatar = Avatar.find(params[:id])
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
    @avatar = Avatar.find(params[:id])
  end

  def update
    @avatar = Avatar.find(params[:id])
    if @avatar.update_attributes(params[:avatar])
      redirect_to :back
    else
      render :action => 'edit'
    end
  end

  def destroy
    @avatar = Avatar.find(params[:id])
    @avatar.destroy
    redirect_to avatars_url, :notice => "Successfully destroyed avatar."
  end
  
  private 
  def load_avatarable
    resource, id = request.path.split('/')[1,2]
    @avatarable = resource.singularize.classify.constantize.find(id)
end
  
  
  
end
