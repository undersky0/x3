require 'rails_helper'

RSpec.describe "blog_posts/edit", :type => :view do
  before(:each) do
    @blog_post = assign(:blog_post, BlogPost.create!(
      :author_name => "MyString",
      :title => "MyString",
      :content => "MyText"
    ))
  end

  it "renders the edit blog_post form" do
    render

    assert_select "form[action=?][method=?]", blog_post_path(@blog_post), "post" do

      assert_select "input#blog_post_author_name[name=?]", "blog_post[author_name]"

      assert_select "input#blog_post_title[name=?]", "blog_post[title]"

      assert_select "textarea#blog_post_content[name=?]", "blog_post[content]"
    end
  end
end
