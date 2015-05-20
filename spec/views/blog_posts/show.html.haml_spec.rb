require 'rails_helper'

RSpec.describe "blog_posts/show", :type => :view do
  #testing
  before(:each) do
    @blog_post = assign(:blog_post, BlogPost.create!(
      :author_name => "Author Name",
      :title => "Title",
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Author Name/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
