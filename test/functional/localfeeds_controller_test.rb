require 'test_helper'

class LocalfeedsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Localfeed.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Localfeed.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Localfeed.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to localfeed_url(assigns(:localfeed))
  end

  def test_edit
    get :edit, :id => Localfeed.first
    assert_template 'edit'
  end

  def test_update_invalid
    Localfeed.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Localfeed.first
    assert_template 'edit'
  end

  def test_update_valid
    Localfeed.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Localfeed.first
    assert_redirected_to localfeed_url(assigns(:localfeed))
  end

  def test_destroy
    localfeed = Localfeed.first
    delete :destroy, :id => localfeed
    assert_redirected_to localfeeds_url
    assert !Localfeed.exists?(localfeed.id)
  end
end
