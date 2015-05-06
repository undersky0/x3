require 'rails_helper'

RSpec.describe "blog_comments/index", :type => :view do
  before(:each) do
    assign(:blog_comments, [
      BlogComment.create!(
        :name => "Name",
        :comment => "MyText",
        :blog_post_id => 1
      ),
      BlogComment.create!(
        :name => "Name",
        :comment => "MyText",
        :blog_post_id => 1
      )
    ])
  end

  it "renders a list of blog_comments" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
