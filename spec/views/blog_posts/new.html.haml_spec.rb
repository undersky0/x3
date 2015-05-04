require 'rails_helper'

RSpec.describe "blog_posts/new", :type => :view do
  before(:each) do
    assign(:blog_post, BlogPost.new(
      :author_name => "MyString",
      :title => "MyString",
      :content => "MyText"
    ))
  end

  it "renders new blog_post form" do
    render

    assert_select "form[action=?][method=?]", blog_posts_path, "post" do

      assert_select "input#blog_post_author_name[name=?]", "blog_post[author_name]"

      assert_select "input#blog_post_title[name=?]", "blog_post[title]"

      assert_select "textarea#blog_post_content[name=?]", "blog_post[content]"
    end
  end
end
