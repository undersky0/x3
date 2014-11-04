require 'test_helper'

class SkillTypeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert SkillType.new.valid?
  end
end
