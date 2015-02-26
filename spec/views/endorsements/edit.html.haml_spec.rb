require 'rails_helper'

RSpec.describe "endorsements/edit", :type => :view do
  before(:each) do
    @endorsement = assign(:endorsement, Endorsement.create!(
      :message => "MyString",
      :user_id => 1,
      :friend_id => 1
    ))
  end

  it "renders the edit endorsement form" do
    render

    assert_select "form[action=?][method=?]", endorsement_path(@endorsement), "post" do

      assert_select "input#endorsement_message[name=?]", "endorsement[message]"

      assert_select "input#endorsement_user_id[name=?]", "endorsement[user_id]"

      assert_select "input#endorsement_friend_id[name=?]", "endorsement[friend_id]"
    end
  end
end
