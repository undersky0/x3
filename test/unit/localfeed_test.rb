require 'test_helper'

class LocalfeedTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Localfeed.new.valid?
  end
end
