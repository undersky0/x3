require 'rails_helper'

RSpec.describe "endorsements/index", :type => :view do
  before(:each) do
    assign(:endorsements, [
      Endorsement.create!(
        :message => "Message",
        :user_id => 1,
        :friend_id => 2
      ),
      Endorsement.create!(
        :message => "Message",
        :user_id => 1,
        :friend_id => 2
      )
    ])
  end

  it "renders a list of endorsements" do
    render
    assert_select "tr>td", :text => "Message".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
