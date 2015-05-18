class BlogCommentsController < ApplicationController
  before_action :set_blog_comment, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  respond_to :html, :json
  def index
    @blog = BlogPost.find(params[:blog_post_id])
    @blog_comments = @blog.blogComments.all
    respond_with(@blog_comments)
  end

  def show
    respond_with(@blog_comment)
  end

  def new
    @blog = BlogPost.find(params[:blog_post_id])
    @blog_comment = @blog.blogComments.new
    respond_with(@blog_comment)
  end

  def edit
  end

  def create
    @blog = BlogPost.find(params[:blog_post_id])
    @blog_comment = @blog.blogComments.new(blog_comment_params)
    @blog_comment.save
    respond_with(@blog_comment)
  end

  def update
    @blog_comment.update(blog_comment_params)
    respond_with(@blog_comment)
  end

  def destroy
    @blog_comment.destroy
    respond_with(@blog_comment)
  end

  private
    def set_blog_comment
      @blog_comment = BlogComment.find(params[:id])
    end

    def blog_comment_params
      params.require(:blog_comment).permit(:name, :comment, :blog_post_id)
    end
end
