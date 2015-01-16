require 'rails_helper'
require 'spec_helper'

RSpec.describe Skill, :type => :model do
  it {should belong_to(:user)}
  it {should have_many(:invites)}
  it {should have_many(:scribbles)}
  it {should have_one(:location)}
  it {should have_one(:skillimage)}
  it {should have_many(:users_joined).conditions(status: 'Joined').with_foreign_key('inviteable_id').class_name('Invite')}
  it {should have_many(:watchers).conditions(status: 'Watched').with_foreign_key('inviteable_id').class_name('Invite')}
  it do 
    should validate_presence_of(:name).with_message("is too short (minimum is 2 characters)")
    should validate_presence_of(:teachers_title).with_message("is too short (minimum is 2 characters)")
    should validate_presence_of(:description).with_message("is too short (minimum is 1 characters)")
    should validate_presence_of(:price)
    should validate_presence_of(:start_date)
    should validate_presence_of(:activity_duration)
    should validate_presence_of(:level)
    should validate_presence_of(:min_students)
    should validate_presence_of(:max_students)
  end
  
  
  it "returns places left" do
    skill = create(:skill, max_students: '10', min_students: '5')
    places = skill.max_students - skill.min_students
    expect(places).to eq 5
  end
  
end
