require 'rails_helper'
require 'spec_helper'
RSpec.describe Asset, :type => :model do
  xit { should belong_to(:assetable)}

  xit "adds new image to root" do
    a = Asset.new
    a = File.new(Rails.root.join('spec/fixtures/images/55.png'))
  end


end
