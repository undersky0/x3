require 'rails_helper'

RSpec.describe "contact_froms/index", :type => :view do
  before(:each) do
    assign(:contact_froms, [
      ContactFrom.create!(
        :name => "Name",
        :email => "Email",
        :messge => "Messge",
        :message_title => "Message Title"
      ),
      ContactFrom.create!(
        :name => "Name",
        :email => "Email",
        :messge => "Messge",
        :message_title => "Message Title"
      )
    ])
  end

  it "renders a list of contact_froms" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Messge".to_s, :count => 2
    assert_select "tr>td", :text => "Message Title".to_s, :count => 2
  end
end
