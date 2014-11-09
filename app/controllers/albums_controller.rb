class AlbumsController < ApplicationController
  before_filter :load_albumable
  
  respond_to :json
  
  def index
    @albums = @albumable.albums
       respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @albums }
    end
  end

  def show
    @album = @albumable.albums.find(params[:id])
    @pictures = Picture.where(album_id: @album.id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
      format.js
    end
        
  end

  def new
    @album = @albumable.albums.new
    @album.token = @album.generate_token
    @picture = @album.pictures.build
    @pictures = []
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @album }
    end
  end

  def create
    @album = @albumable.albums.new(params[:album])
    @pictures = Picture.where(:album_token => @album.token)
    @album.pictures << @pictures
    
    respond_to do |format|
      if @album.save
        format.html { redirect_to @albumable, notice: 'Gallery was successfully created.' }
        format.json { render json: @albumable, status: :created, location: @album }
      else
        format.html { render action: "new" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

    @album = @albumable.albums.find(params[:id])
    @picture = @album.pictures.build
    @picture = []
    
  end

  def update
    @album = @albumable.albums.find(params[:id])
    
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
    @albumable = load_albumable
    @album = @albumable.albums.find(params[:id])
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
end
