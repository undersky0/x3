require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_one(:location).dependent(:destroy)}
  it { should have_many(:scribbles)}
  it { should have_one(:useravatar).dependent(:destroy)}
  it { should have_one(:usercover).dependent(:destroy)}
  it { should have_one(:profile).dependent(:destroy)}
  it { should have_many(:groups)}
  it { should have_many(:friends).through(:friendship)}
  it { should have_many(:pending_friends).through(:friendship)}
  it { should have_many(:requested_friends).through(:friendship)}
  it { should have_many(:friendship)}
  it { should have_many(:invites)}
  it { should have_many(:invitations)}
  it { should have_many(:authentications)}
  it { should have_many(:skills).dependent(:destroy)}
  it { should have_many(:albums).dependent(:destroy)}
  
  it "returns a users's full name as a st1ring" do
    user = create(:user)
    profile = create(:profile)
    user.profile = profile
    expect(user.full_name).to eq 'John Doe'
  end
  
  context "create user" do
    user = User.create(email: "test@test.com", password: "testtest", password_confirmation: "testtest")
  end

end
