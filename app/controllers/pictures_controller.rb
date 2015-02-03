class PicturesController < ApplicationController
    before_filter :set_picture, only: [:show, :update, :make_default]
    before_filter :set_album, only: [:make_default, :destroy, :edit, :index, :new]
    respond_to :json
  def load_albumable
    resource, id = request.path.split('/')[1,2]
    @albumable = resource.singularize.classify.constantize.find(id)
  end
  
  def index
    @albumpicture = @album.pictures
    @pictures = @albumable.pictures.all
    render :json => @pictures.collect { |p| p.to_jq_upload }.to_json 
  end

  def show
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pictures }
    end
  end

  def new
    @picture = @album.pictures.build
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
    @picture = @album.pictures.find(params[:id])
  end

  def update
    if @picture.update_attributes(params[:picture])
      redirect_to @picture, :notice  => "Successfully updated picture."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @picture = @album.pictures.find(params[:picture_id])
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
  
  def make_default
    @album.cover = @picture.id
    @album.save
    respond_to do |format|
      format.js
    end
  end
  private
  def set_picture
    @picture = Picture.find(params[:id])
  end
  
  def set_album
    @album = Album.find(params[:album_id] || params[:galery_id])
  end
end
