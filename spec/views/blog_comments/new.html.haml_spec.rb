require 'rails_helper'

RSpec.describe "blog_comments/new", :type => :view do
  before(:each) do
    assign(:blog_comment, BlogComment.new(
      :name => "MyString",
      :comment => "MyText",
      :blog_post_id => 1
    ))
  end

  it "renders new blog_comment form" do
    render

    assert_select "form[action=?][method=?]", blog_comments_path, "post" do

      assert_select "input#blog_comment_name[name=?]", "blog_comment[name]"

      assert_select "textarea#blog_comment_comment[name=?]", "blog_comment[comment]"

      assert_select "input#blog_comment_blog_post_id[name=?]", "blog_comment[blog_post_id]"
    end
  end
end
