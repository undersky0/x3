require 'rails_helper'
require 'spec_helper'
RSpec.describe Location, :type => :model do
  
  # create(:location, postcode: "CF24 1PL")
  
  it { should have_many(:scribbles) }
  it { should validate_presence_of(:address).with_message("Address can't be blank") }
  it { should validate_presence_of(:city).with_message("can't be blank") }
  it { should validate_presence_of(:postcode).with_message("invalid postcode") }
  
  it "is invalid without postcode" do
   l = build(:location, postcode: "gdsgdgdfgd")
   expect(l).not_to be_valid
  end
  it "valid with postcode" do
    expect(build(:location, postcode: "CF24 1PL")).to be_valid
  end

  describe '#get_ward' do
    location = FactoryGirl.build(:location, :postcode => "CF24 1PL")
  it "returns locations ward" do
    
    response = HTTParty.get("http://api.postcodes.io/postcodes/cf241pl").parsed_response    
    location.locality = response["result"]["admin_ward"]
    location.political = response["result"]["parliamentary_constituency"]
    location.city = response["result"]['admin_district']
    expect(response["status"]).to eq 200
  end
  
  it "creates localfeed if ward doesn't exist" do
    l = Location.where(locality: location.locality.downcase).count
    expect(l).to eq 0
  end
  end
  
  describe 'to_s' do
    it "returns location components" do 
      location = build(:location, :postcode => "CF24 1PL")
      string = "#{location.address} " + " #{location.postcode}" + " GB"
      expect(string).not_to be_nil
      puts string
    end
  end
  
  describe 'create localfeed' do 
    it 'should created localfeed' do 
      location = build(:location, postcode: "CF24 1PL")
      location.type = "Localfeed"
      expect(location.type).to eq "Localfeed"
      #location.should_receive(:get_ward)
    end
    it 'should create localfeed' do 
      l1 = create(:location, postcode: "CF24 1PL")
      l2 = create(:location, postcode: "CF24 1PL")
      s = Location.where(locality: l2.locality).count
      puts s
    end
  end
    describe 'after_save' do
    it 'should run the proper callbacks' do
      location = create(:location, postcode: "CF24 1PL")
      expect(location).to receive(:get_ward)
      location.run_callbacks(:save) {false}
    end
  end

  
  
end