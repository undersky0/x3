require 'test_helper'

class UsersCellTest < Cell::TestCase
  test "show" do
    invoke :show
    assert_select "p"
  end
  

end
