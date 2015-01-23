require 'rails_helper'

RSpec.describe "ContactFroms", :type => :request do
  describe "GET /contact_froms" do
    it "works! (now write some real specs)" do
      get contact_froms_path
      expect(response).to have_http_status(200)
    end
  end
end
