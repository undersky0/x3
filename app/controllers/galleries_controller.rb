class GalleriesController < ApplicationController
  
  before_filter :load_gallery
  
  def index
    @galleries = @gallerable.galeries
  end

  def show
    @gallery = Gallery.find(params[:id])
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
    @gallery = Gallery.find(params[:id])
  end

  def update
    @gallery = Gallery.find(params[:id])
    if @gallery.update_attributes(params[:gallery])
      redirect_to @gallery, :notice  => "Successfully updated gallery."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @gallery = Gallery.find(params[:id])
    @gallery.destroy
    redirect_to galleries_url, :notice => "Successfully destroyed gallery."
  end
  
  private
  def load_gallery
    resource, id = request.path.split('/')[1,2]
    @gallerable = resource.singularize.classify.constantize.find(id)
  end
end
