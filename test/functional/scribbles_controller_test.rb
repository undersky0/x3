require 'test_helper'

class ScribblesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Scribble.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Scribble.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Scribble.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to scribble_url(assigns(:scribble))
  end

  def test_edit
    get :edit, :id => Scribble.first
    assert_template 'edit'
  end

  def test_update_invalid
    Scribble.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Scribble.first
    assert_template 'edit'
  end

  def test_update_valid
    Scribble.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Scribble.first
    assert_redirected_to scribble_url(assigns(:scribble))
  end

  def test_destroy
    scribble = Scribble.first
    delete :destroy, :id => scribble
    assert_redirected_to scribbles_url
    assert !Scribble.exists?(scribble.id)
  end
end
