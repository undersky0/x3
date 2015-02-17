require 'rails_helper'
require 'spec_helper'
RSpec.describe Comment, :type => :model do
  it { should belong_to(:user)}
  it { should belong_to(:commentable)}
end
