require 'rails_helper'

RSpec.describe Album, :type => :model do
  it { should have_many(:pictures).dependent(:destroy) }
  it { should belong_to(:albumable)}
end
