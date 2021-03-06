class ScribblesController < ApplicationController
  # GET /scribbles
  # GET /scribbles.json
  before_filter :set_scribble, except:[:create, :new]
    
  def promote
    @user = current_user
      if @user.flagged?(@scribble, :promote)
          @user.unflag(@scribble, :promote)
      else
          @user.flag(@scribble, :promote)
      end
    redirect_to @scribbled, :notice => "Liked!"
  end
  
  
  def vote
    @vote = params[:vote]
    if @vote == "true"
      current_user.vote(@scribble, :direction => :up)
    else
      current_user.unvote_for(@scribble)
    end
    respond_to do |format|
      scribble = @scribble
      format.js{}
    end
  end
  
  def vote_against
    scribble = Scribble.find(params[:scribble_id])
    current_user.vote_against(scribble)
    render :nothing => true, :notice => "Demoted"
  end
    
  def index   
  end

  def edit
  end
  

  def create
    @user = current_user
    @scribble = @user.scribbles.new(params[:scribble])
    @scribble.scribbled_type = params[:scribbled_type]
    @scribble.scribbled_id = params[:scribbled_id]
    respond_to do |format|
      if @scribble.save
        unless params[:scribbled_type]  == "User"
        @scribbles = @scribble.scribbled.scribbles.order("created_at DESC")
        else
        @scribbles = Scribble.where(scribbled_type: "User", scribbled_id: @scribble.scribbled_id).order("created_at DESC")
        end
        format.js{}
      end
    end
    
    if params[:file].present?
      @scribble.file = params[:file]
      @scribble.save!
      respond_to do |format|
      format.json{ render :json => @scribble }
    end
    end

  end

  def update
    respond_to do |format|
      if @scribble.update_attributes(params[:scribble])
        format.html { redirect_to @scribble, :notice => 'Scribble was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @scribble.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /scribbles/1
  # DELETE /scribbles/1.json
  def destroy
    @scribble.destroy
    respond_to do |format|
      format.html { redirect_to scribbles_url }
      format.json { head :no_content }
    end
  end
  
  def load_scribbled
  resource, id = request.path.split('/')[1,2]
  @scribbled = resource.singularize.classify.constantize.find(id)
  end
      private
  
  def set_scribble
     @scribble = Scribble.find(params[:id])
  end
end