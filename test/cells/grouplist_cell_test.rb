require 'test_helper'

class GrouplistCellTest < Cell::TestCase
  test "show" do
    invoke :show
    assert_select "p"
  end
  

end
