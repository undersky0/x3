require 'rails_helper'

RSpec.describe BlogPost, :type => :model do
  it { should have_one(:blogpostattachment) }
  it { should accept_nested_attributes_for(:blogpostattachment) }
  it { should have_many(:blogComments)}


  describe "keyword extraction" do
    blog = FactoryGirl.create(:blog_post)
    it "expect keywords to be nil" do
      expect(blog.keywords).to be_nil
    end

    it "should receive keyword_extraction" do
      b = FactoryGirl.build(:blog_post, keywords: "green", content: "Suspendo caute vorax curso facere textus.")
      b.save!
      expect(b.keywords.length).to be > 5
      expect(b.keywords).to eq("green, caute vorax curso")
    end
  end
end
