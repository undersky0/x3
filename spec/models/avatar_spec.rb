require 'rails_helper'
RSpec.describe Avatar, :type => :model do

  it { should have_attached_file(:photo) }
  it { should validate_attachment_presence(:photo) }
  it { should validate_attachment_content_type(:photo).
                allowing('image/png', 'image/gif', 'image/jpeg').
                rejecting('text/plain', 'text/xml') }
  it { should validate_attachment_size(:photo).
                less_than(2.megabytes) }

end
