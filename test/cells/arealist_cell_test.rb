require 'test_helper'

class ArealistCellTest < Cell::TestCase
  test "show" do
    invoke :show
    assert_select "p"
  end
  

end
