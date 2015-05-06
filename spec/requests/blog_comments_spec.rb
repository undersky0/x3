require 'rails_helper'

RSpec.describe "BlogComments", :type => :request do
  describe "GET /blog_comments" do
    it "works! (now write some real specs)" do
      get blog_comments_path
      expect(response).to have_http_status(200)
    end
  end
end
