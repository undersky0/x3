require 'test_helper'

class SkillTypesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => SkillType.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    SkillType.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    SkillType.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to skill_type_url(assigns(:skill_type))
  end

  def test_edit
    get :edit, :id => SkillType.first
    assert_template 'edit'
  end

  def test_update_invalid
    SkillType.any_instance.stubs(:valid?).returns(false)
    put :update, :id => SkillType.first
    assert_template 'edit'
  end

  def test_update_valid
    SkillType.any_instance.stubs(:valid?).returns(true)
    put :update, :id => SkillType.first
    assert_redirected_to skill_type_url(assigns(:skill_type))
  end

  def test_destroy
    skill_type = SkillType.first
    delete :destroy, :id => skill_type
    assert_redirected_to skill_types_url
    assert !SkillType.exists?(skill_type.id)
  end
end
