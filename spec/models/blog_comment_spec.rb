require 'rails_helper'

RSpec.describe BlogComment, :type => :model do
  it {should belong_to(:blogPost).dependent(:destroy)}
  it {should validate_presence_of(:comment)}
  it {should validate_presence_of(:name)}
end
