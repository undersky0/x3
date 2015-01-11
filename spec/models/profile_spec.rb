require 'rails_helper'

RSpec.describe Profile, :type => :model do
  
  it { should belong_to(:user)}
  
  it "has a valid factory" do
    expect(FactoryGirl.build(:profile)).to be_valid
  end

  it "is valid with a firstname and lastname" do
  profile = FactoryGirl.build(:profile, firstname: 'Richard', lastname: 'Lonesteen')
  expect(profile).to be_valid
  end
  
  it "is invalid without firstname" do
    profile = Profile.new(firstname: nil)
    profile.valid?
    expect(profile.errors[:firstname]).not_to include("can't be blank")
  end
  
  it "is invalid without lastname" do
    profile = Profile.new(lastname: nil)
    profile.valid?
    expect(profile.errors[:lastname]).not_to include("can't be blank")
  end
  
end
