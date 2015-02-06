class GalleriesController < ApplicationController
  
  before_filter :load_gallery
  before_action :set_gallery, only: [:show,:edit,:update,:destroy]
  
  def index
    @galleries = @gallerable.galeries
  end

  def show
  end

  def new
    @gallery = @gallerable.galleries.new
  end

  def create
    @gallery = @gallerable.galleries.new(params[:gallery])
    if @gallery.save
      redirect_to @gallery, :notice => "Successfully created gallery."
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @gallery.update_attributes(params[:gallery])
      redirect_to @gallery, :notice  => "Successfully updated gallery."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @gallery.destroy
    redirect_to galleries_url, :notice => "Successfully destroyed gallery."
  end
  
  def set_gallery
    @gallery = Gallery.find(params[:id])
  end
  private
  def load_gallery
    resource, id = request.path.split('/')[1,2]
    @gallerable = resource.singularize.classify.constantize.find(id)
  end
end
