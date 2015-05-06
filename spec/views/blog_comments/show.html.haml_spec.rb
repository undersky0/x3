require 'rails_helper'

RSpec.describe "blog_comments/show", :type => :view do
  before(:each) do
    @blog_comment = assign(:blog_comment, BlogComment.create!(
      :name => "Name",
      :comment => "MyText",
      :blog_post_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
  end
end
