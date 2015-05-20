class BlogCommentsController < ApplicationController
  skip_filter :authenticate_user!
  skip_filter :redirect_invalid_locations
  skip_before_action :verify_authenticity_token
  respond_to :html, :json

  def new
    @blog = BlogPost.find(params[:blog_post_id])
    @blog_comment = @blog.blogComments.new
    respond_with(@blog_comment)
  end

  def create
    @blog = BlogPost.find(params[:blog_post_id])
    @blog_comment = @blog.blogComments.new(blog_comment_params)
    if @blog_comment.save
      render json: @blog_comment, status: 200, location: @blog_comment
    else
      render json: @blog_comment.errors, status: :unprocessable_entity
    end
  end

  private
    def set_blog_comment
      @blog_comment = BlogComment.find(params[:id])
    end

    def blog_comment_params
      params.require(:blog_comment).permit(:name, :comment, :blog_post_id)
    end
end
