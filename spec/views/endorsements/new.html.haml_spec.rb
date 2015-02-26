require 'rails_helper'

RSpec.describe "endorsements/new", :type => :view do
  before(:each) do
    assign(:endorsement, Endorsement.new(
      :message => "MyString",
      :user_id => 1,
      :friend_id => 1
    ))
  end

  it "renders new endorsement form" do
    render

    assert_select "form[action=?][method=?]", endorsements_path, "post" do

      assert_select "input#endorsement_message[name=?]", "endorsement[message]"

      assert_select "input#endorsement_user_id[name=?]", "endorsement[user_id]"

      assert_select "input#endorsement_friend_id[name=?]", "endorsement[friend_id]"
    end
  end
end
