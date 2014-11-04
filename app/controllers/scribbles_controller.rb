class ScribblesController < ApplicationController
   # GET /scribbles
  # GET /scribbles.json
    #before_filter :load_scribbled
    before_filter :load_posts
    respond_to :json
    
  def load_posts
    @scribbles = Scribble.all(:order => "created_at DESC")
    @scribble = Scribble.new
  end
    
  def promote
    @user = current_user
    @scribble = Scribble.find(params[:id])
      if @user.flagged?(@scribble, :promote)
          @user.unflag(@scribble, :promote)
      else
          @user.flag(@scribble, :promote)
  end
  redirect_to @scribbled, :notice => "Liked!"
  end
  
  
  def vote
  @scribble = Scribble.find(params[:id])
  @vote = params[:vote]
  if @vote == "true"
    @v = :up
    current_user.vote(@scribble, :direction => @v)
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

  # GET /scribbles/1
  # GET /scribbles/1.json

  # GET /scribbles/1/edit
  def edit
    @scribble = Scribble.find(params[:id])
  end
  
  # POST /scribbles
  # POST /scribbles.json
  def create
    @user = current_user
    @scribble = @user.scribbles.new(params[:scribble])
    @scribble.promotes = 0
    @scribble.demotes = 0
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
  

  # PUT /scribbles/1
  # PUT /scribbles/1.json
  def update
    @scribble = Scribble.find(params[:id])

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
    @scribble = Scribble.find(params[:id])
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
    
end