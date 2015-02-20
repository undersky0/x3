require 'rails_helper'

RSpec.describe Project, :type => :model do
  it { should belong_to(:user) }
  it { should belong_to(:skill) }
  it { should have_one(:projectimage)}
  it { should validate_presence_of(:name)}
end
