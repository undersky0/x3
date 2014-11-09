class PicturesController < ApplicationController
#  before_filter :load_albumable
respond_to :json
    def load_albumable
    resource, id = request.path.split('/')[1,2]
    @albumable = resource.singularize.classify.constantize.find(id)
  end
  def index
    
    @album = Album.find(params[:album_id])
    @albumpicture = @album.pictures
    @pictures = @albumable.pictures.all
    render :json => @pictures.collect { |p| p.to_jq_upload }.to_json
    
    
  end

  def show
    @picture = Picture.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pictures }
    end
  end

  def new
    @album = Album.find(params[:gallery_id])
    @picture = @album.pictures.build
    #@picture = Picture.new(:album_id => params[:album_id])
    @object_new = Picture.new
    
  end

  def create
      p_attr = params[:file]
      @album = Album.find(params[:picture][:album_id])
      @picture = @album.pictures
    
    respond_to do |format|
    if params[:picture][:file].present?
        params[:picture][:file].each do |a|
          @album.pictures.create(file: a)
        format.html {redirect_to :back}
      end
    else
      format.html {redirect_to :back, :notice => "please browse for right picture first"}
    end   
  end
  end

  def edit
    @album = Album.find(params[:gallery_id])
    @picture = @album.pictures.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])
    if @picture.update_attributes(params[:picture])
      redirect_to @picture, :notice  => "Successfully updated picture."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @album = Album.find(params[:album_id])
    @picture = @album.pictures.find(params[:picture_id])
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
  
  def make_default
    @picture = Picture.find(params[:id])
    @album = Album.find(params[:album_id])
    @album.cover = @picture.id
    @album.save
    respond_to do |format|
      format.js
    end
  end
  
end
