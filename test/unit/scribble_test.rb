require 'test_helper'

class ScribbleTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Scribble.new.valid?
  end
end
