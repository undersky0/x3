class AlbumsController < ApplicationController
  before_filter :load_albumable
  before_action :set_album, only: [:destroy,:show, :edit, :update]
  respond_to :html, :json
  def index
    @albums = @albumable.albums
    respond_with(@albums)
  end

  def show
    @pictures = Picture.where(album_id: @album.id)
  end

  def new
    @album = @albumable.albums.new
    @album.token = @album.generate_token
    @picture = @album.pictures.build
    @pictures = []
  end

  def create
    @album = @albumable.albums.new(params[:album])
    @pictures = Picture.where(:album_token => @album.token)
    @album.pictures << @pictures
    respond_to do |format|
      if @album.save
        format.html { redirect_to polymorphic_url([@albumable, @album]), notice: 'Gallery was successfully created.' }
        format.json { render json: @albumable, status: :created, location: @album }      
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @picture = @album.pictures.build
    @picture = []
  end

  def update  
    respond_to do |format|
      if @album.update_attributes(params[:album])
        format.html { redirect_to @albumable, notice: 'Gallery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
   @album.destroy
   respond_to do |format|
      format.html { redirect_to albums_url }
      format.json { head :no_content }
    end
  end
  
  private 
  
  def load_albumable
    resource, id = request.path.split('/')[1,2]
    @albumable = resource.singularize.classify.constantize.find(id)
  end
  
  def set_album
    @albumable = load_albumable
    @album = @albumable.albums.find(params[:id]) 
 end
end
