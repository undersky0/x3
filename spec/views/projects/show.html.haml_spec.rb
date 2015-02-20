require 'rails_helper'

RSpec.describe "projects/show", :type => :view do
  before(:each) do
    @project = assign(:project, Project.create!(
      :name => "Name",
      :about => "About",
      :user_id => 1,
      :skill_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/About/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
