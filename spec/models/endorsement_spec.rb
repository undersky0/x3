require 'rails_helper'
require 'spec_helper'
RSpec.describe Endorsement, :type => :model do
  it { should belong_to(:user) }
  it { should belong_to(:endorser).class_name("User") }
end
