require 'rails_helper'

RSpec.describe "contact_froms/show", :type => :view do
  before(:each) do
    @contact_from = assign(:contact_from, ContactFrom.create!(
      :name => "Name",
      :email => "Email",
      :messge => "Messge",
      :message_title => "Message Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Messge/)
    expect(rendered).to match(/Message Title/)
  end
end
