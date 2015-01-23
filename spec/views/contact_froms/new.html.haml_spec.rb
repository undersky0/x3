require 'rails_helper'

RSpec.describe "contact_froms/new", :type => :view do
  before(:each) do
    assign(:contact_from, ContactFrom.new(
      :name => "MyString",
      :email => "MyString",
      :messge => "MyString",
      :message_title => "MyString"
    ))
  end

  it "renders new contact_from form" do
    render

    assert_select "form[action=?][method=?]", contact_froms_path, "post" do

      assert_select "input#contact_from_name[name=?]", "contact_from[name]"

      assert_select "input#contact_from_email[name=?]", "contact_from[email]"

      assert_select "input#contact_from_messge[name=?]", "contact_from[messge]"

      assert_select "input#contact_from_message_title[name=?]", "contact_from[message_title]"
    end
  end
end
