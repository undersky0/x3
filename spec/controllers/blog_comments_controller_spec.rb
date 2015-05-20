require 'rails_helper'
require 'spec_helper'
RSpec.describe BlogCommentsController, :type => :controller do

  describe "GET new" do
    it "assigns a new blog_comment as @blog_comment" do
      blog_post = create(:blog_post)
      get :new, {:blog_post_id => blog_post.id}
      expect(assigns(:blog_comment)).to be_a_new(BlogComment)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new BlogComment" do
        blog_post = create(:blog_post)
        expect {
          post :create, {:blog_post_id => blog_post.id, :blog_comment => attributes_for(:blog_comment)}
        }.to change(BlogComment, :count).by(1)
      end

      it "assigns a newly created blog_comment as @blog_comment" do
        blog_post = create(:blog_post)
        post :create, {:blog_post_id => blog_post.id, :blog_comment => attributes_for(:blog_comment)}
        expect(assigns(:blog_comment)).to be_a(BlogComment)
        expect(assigns(:blog_comment)).to be_persisted
      end

      it "redirects to the created blog_comment" do
        blog_post = create(:blog_post)
        post :create, {:blog_post_id => blog_post.id, :blog_comment => attributes_for(:blog_comment)}
        expect(response.status).to eq(200)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved blog_comment as @blog_comment" do
        blog_post = create(:blog_post)
        post :create, {:blog_post_id => blog_post.id, :blog_comment => attributes_for(:blog_comment, name: "")}
        expect(assigns(:blog_comment)).to be_a_new(BlogComment)
      end

      it "returns status :unprocessable_entry" do
        blog_post = create(:blog_post)
        post :create, {:blog_post_id => blog_post.id, :blog_comment => attributes_for(:blog_comment, name: "")}
        expect(response.status).to eq(422)
      end
    end
  end
end
