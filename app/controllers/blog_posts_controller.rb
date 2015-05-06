class BlogPostsController < ApplicationController
  skip_filter :authenticate_user!
  skip_filter :redirect_invalid_locations
  layout "about"
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]

  respond_to :html
  http_basic_authenticate_with name: "demon", password: ENV['blog_pw'], only: [:edit, :destroy, :new, :create]
  def index
    @blog_posts = BlogPost.all.order('created_at DESC')
    respond_with(@blog_posts)
  end

  def show
    respond_with(@blog_post)
  end

  def new
    @blog_post = BlogPost.new
    respond_with(@blog_post)
  end

  def edit
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    @blog_post.save
    respond_with(@blog_post)
  end

  def update
    @blog_post.update(blog_post_params)
    respond_with(@blog_post)
  end

  def destroy
    @blog_post.destroy
    respond_with(@blog_post)
  end


  private
    def set_blog_post
      @blog_post = BlogPost.find(params[:id])
    end

    def blog_post_params
      params.require(:blog_post).permit(:author_name, :title, :content, :keywords, blogpostattachment_attributes: :attachment)
    end
end
