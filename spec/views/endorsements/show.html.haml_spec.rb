require 'rails_helper'

RSpec.describe "endorsements/show", :type => :view do
  before(:each) do
    @endorsement = assign(:endorsement, Endorsement.create!(
      :message => "Message",
      :user_id => 1,
      :friend_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Message/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
