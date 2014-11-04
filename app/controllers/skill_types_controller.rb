class SkillTypesController < ApplicationController
  def index
    @skill_types = SkillType.all
  end

  def show
    @skill_type = SkillType.find(params[:id])
  end

  def new
    @skill_type = SkillType.new
  end

  def create
    @skill_type = SkillType.new(params[:skill_type])
    if @skill_type.save
      redirect_to @skill_type, :notice => "Successfully created skill type."
    else
      render :action => 'new'
    end
  end

  def edit
    @skill_type = SkillType.find(params[:id])
  end

  def update
    @skill_type = SkillType.find(params[:id])
    if @skill_type.update_attributes(params[:skill_type])
      redirect_to @skill_type, :notice  => "Successfully updated skill type."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @skill_type = SkillType.find(params[:id])
    @skill_type.destroy
    redirect_to skill_types_url, :notice => "Successfully destroyed skill type."
  end
end
