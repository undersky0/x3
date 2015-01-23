require "rails_helper"

RSpec.describe ContactFromsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/contact_froms").to route_to("contact_froms#index")
    end

    it "routes to #new" do
      expect(:get => "/contact_froms/new").to route_to("contact_froms#new")
    end

    it "routes to #show" do
      expect(:get => "/contact_froms/1").to route_to("contact_froms#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/contact_froms/1/edit").to route_to("contact_froms#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/contact_froms").to route_to("contact_froms#create")
    end

    it "routes to #update" do
      expect(:put => "/contact_froms/1").to route_to("contact_froms#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/contact_froms/1").to route_to("contact_froms#destroy", :id => "1")
    end

  end
end
