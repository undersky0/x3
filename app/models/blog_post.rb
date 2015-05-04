class BlogPost < ActiveRecord::Base
  has_one :blogpostattachment, :as => :assetable, :class_name => "Group::BlogPostAttachment", :dependent => :destroy
  accepts_nested_attributes_for :blogpostattachment, reject_if: :all_blank
  before_save :keyword_extraction
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  def keyword_extraction
    results = AlchemyAPI.search(:keyword_extraction, html: self.content.html_safe)
    keywords = ''
    if results.nil?
       nil
    else
      results.each{ |r| self.keywords << ", #{r['text']}" if self.keywords.length < 220}
      #if r['relevance'].to_f > 0.2
    end
  end
end
