require 'rails_helper'

RSpec.describe Skill, :type => :model do
  it {should belong_to(:user)}
  it {should have_many(:invites)}
  it {should have_many(:scribbles)}
  it {should have_one(:location)}
  it {should have_one(:skillimage)}
  it {should have_many(:users_joined).conditions(status: 'Joined').with_foreign_key('inviteable_id').class_name('Invite')}
  it {should have_many(:watchers).conditions(status: 'Watched').with_foreign_key('inviteable_id').class_name('Invite')}
  
  
  it "returns places left" do
    skill = create(:skill, max_students: '10', min_students: '5')
    places = skill.max_students - skill.min_students
    places.should == 5
  end
  
end
