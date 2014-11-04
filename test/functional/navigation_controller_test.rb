require 'test_helper'

class NavigationControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get feeds" do
    get :feeds
    assert_response :success
  end

end
