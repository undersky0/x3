require "rails_helper"

RSpec.describe BlogCommentsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/blog_comments").to route_to("blog_comments#index")
    end

    it "routes to #new" do
      expect(:get => "/blog_comments/new").to route_to("blog_comments#new")
    end

    it "routes to #show" do
      expect(:get => "/blog_comments/1").to route_to("blog_comments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/blog_comments/1/edit").to route_to("blog_comments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/blog_comments").to route_to("blog_comments#create")
    end

    it "routes to #update" do
      expect(:put => "/blog_comments/1").to route_to("blog_comments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/blog_comments/1").to route_to("blog_comments#destroy", :id => "1")
    end

  end
end
