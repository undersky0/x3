require 'test_helper'

class AttachablesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Attachables.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Attachables.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Attachables.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to attachables_url(assigns(:attachables))
  end

  def test_edit
    get :edit, :id => Attachables.first
    assert_template 'edit'
  end

  def test_update_invalid
    Attachables.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Attachables.first
    assert_template 'edit'
  end

  def test_update_valid
    Attachables.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Attachables.first
    assert_redirected_to attachables_url(assigns(:attachables))
  end

  def test_destroy
    attachables = Attachables.first
    delete :destroy, :id => attachables
    assert_redirected_to attachables_url
    assert !Attachables.exists?(attachables.id)
  end
end
