class CommentsController < ApplicationController
  before_filter :load_commentable
  
    def vote
  @comment = Comment.find(params[:id])
  @vote = params[:vote]
  if @vote == "true"
    @v = :up
    current_user.vote(@comment, :direction => @v)
  else
    current_user.unvote_for(@comment)
  end
    respond_to do |format|
      format.js{}
  end
  end
  
  def index
    @commentable = load_commentable
    @comments = @commentable.comments(:all, :order => 'comments.created_at ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @comments }
    end
  end
  
  def new
    @comment = @commentable.comments.new  
  end
  
    def create
    @user = current_user
    @commentable = load_commentable
    @comment = @commentable.comments.new(params[:comment])
    
    respond_to do |format|
    if @comment.save
      @user.comments << @comment
      format.js {}
    end
    end
    
  end
  
  private

  def load_commentable
    if params[:scribble_id]
      @commentable = Scribble.find(params[:scribble_id])
    end
    
    # klass = [Scribble].detect { |c| params["#{c.name.underscore}_id"] }
    # @commentable = klass.find(params["#{klass.name.underscore}_id"])
  end
  
end
