require 'rails_helper'

RSpec.describe "projects/new", :type => :view do
  before(:each) do
    assign(:project, Project.new(
      :name => "MyString",
      :about => "MyString",
      :user_id => 1,
      :skill_id => 1
    ))
  end

  it "renders new project form" do
    render

    assert_select "form[action=?][method=?]", projects_path, "post" do

      assert_select "input#project_name[name=?]", "project[name]"

      assert_select "input#project_about[name=?]", "project[about]"

      assert_select "input#project_user_id[name=?]", "project[user_id]"

      assert_select "input#project_skill_id[name=?]", "project[skill_id]"
    end
  end
end
