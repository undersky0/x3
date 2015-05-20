require 'rails_helper'

RSpec.describe BlogPostsController, :type => :controller do
  include AuthHelper
  let(:valid_attributes) {
    author_name "MyString"
    title "MyString"
    content {Faker::Lorem.sentence(3, true)}
    keywords "green"
  }

  let(:invalid_attributes) {
    author_name ""
    title "MyString"
    content {Faker::Lorem.sentence(3, true)}
    keywords "green"
  }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all blog_posts as @blog_posts" do
      blog_post = create(:blog_post)
      get :index
      expect(assigns(:blog_posts)).to eq([blog_post])
    end
  end

  describe "GET show" do
    it "assigns the requested blog_post as @blog_post" do
      blog_post = create(:blog_post)
      get :show, {:id => blog_post.to_param}, valid_session
      expect(assigns(:blog_post)).to eq(blog_post)
    end
  end


  describe "GET new" do
    it "assigns a new blog_post as @blog_post" do
      http_login
      get :new
      expect(assigns(:blog_post)).to be_a_new(BlogPost)
    end
  end

  describe "GET edit" do
    it "assigns the requested blog_post as @blog_post" do
      http_login
      blog_post = create(:blog_post)
      get :edit, {:id => blog_post.to_param}
      expect(assigns(:blog_post)).to eq(blog_post)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new BlogPost" do
        http_login
        expect {
          post :create, {:blog_post => attributes_for(:blog_post)}
        }.to change(BlogPost, :count).by(1)
      end

      it "assigns a newly created blog_post as @blog_post" do
        http_login
        post :create, {:blog_post => attributes_for(:blog_post)}
        expect(assigns(:blog_post)).to be_a(BlogPost)
        expect(assigns(:blog_post)).to be_persisted
      end

      it "redirects to the created blog_post" do
        http_login
        post :create, {:blog_post => attributes_for(:blog_post)}
        expect(response).to redirect_to(BlogPost.last)
      end
    end
    describe "with invalid params" do
      it "assigns a newly created but unsaved blog_post as @blog_post" do
        http_login
        post :create, {:blog_post => attributes_for(:blog_post, content: "")}
        expect(assigns(:blog_post)).to be_a_new(BlogPost)
      end

      it "re-renders the 'new' template" do
        http_login
        post :create, {:blog_post => attributes_for(:blog_post, content: "")}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      fit "updates the requested blog_post" do
        http_login
        blog_post = create(:blog_post)
        put :update, {:id => blog_post.to_param, :blog_post => attributes_for(:blog_post, content: "a")}
        blog_post.reload
        expect(blog_post.content).to eq("a")
      end

      it "assigns the requested blog_post as @blog_post" do
        http_login
        blog_post = create(:blog_post)
        put :update, {:id => blog_post.to_param, :blog_post => attributes_for(:blog_post, content: "a")}
        expect(assigns(:blog_post)).to eq(blog_post)
      end

      it "redirects to the blog_post" do
        http_login
        blog_post = create(:blog_post)
        put :update, {:id => blog_post.to_param, :blog_post => attributes_for(:blog_post, content: "a")}
        expect(response).to redirect_to(blog_post)
      end
    end

    describe "with invalid params" do
      it "assigns the blog_post as @blog_post" do
        http_login
        blog_post = create(:blog_post)
        put :update, {:id => blog_post.to_param, :blog_post => attributes_for(:blog_post, content: "a")}
        expect(assigns(:blog_post)).to eq(blog_post)
      end

      it "re-renders the 'edit' template" do
        http_login
        blog_post = create(:blog_post)
        put :update, {:id => blog_post.to_param, :blog_post => attributes_for(:blog_post, content: "")}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested blog_post" do
      http_login
      blog_post = create(:blog_post)
      expect {
        delete :destroy, {:id => blog_post.to_param}
      }.to change(BlogPost, :count).by(-1)
    end

    it "redirects to the blog_posts list" do
      http_login
      blog_post = create(:blog_post)
      delete :destroy, {:id => blog_post.to_param}
      expect(response).to redirect_to(blog_posts_url)
    end
  end
end
