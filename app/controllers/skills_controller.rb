class SkillsController < ApplicationController
  before_action :set_skill, only: [:show, :edit, :update, :destroy]
  def index
    #search by word && type && ID
    if params[:q].present?
      @s = Skill.search(params[:q], fields: [{name: :word_start}], misspellings: true, limit:3)
      @skills = Kaminari.paginate_array(@s).page(params[:page]).per(25)
    end   
    if params[:id].present?
      @s = Skill.where(skill_type_id: params[:id])
      @skills = Kaminari.paginate_array(@s).page(params[:page]).per(25)
    end 
    
    if params[:skill_id].present?
      @users = Skill.find(params[:skill_id])
       respond_to do |format|
          format.html {render partial: "skills/joined"}
          format.js
       end
    end
    
    @skills = Kaminari.paginate_array(Skill.all).page(params[:page]).per(25)
    @skilltypes = SkillType.all
    @skill = User.all
  end

  def show
    @location = @skill.location
    @distance_from ||= @location.distance_to(current_user.location) if !@location.nil?
    @scribbled = @skill
    @scribbles = @scribbled.scribbles.order("created_at DESC").page params[:page]
  end

  def new
    @user = current_user
    @skill = @user.skills.new
    @skill.build_skillimage
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @skill }
    end
  end

  def create
    @user = current_user
    @skill = @user.skills.build(skill_params)
    if @skill.save
      redirect_to new_skill_locations_path(@skill), :notice => "Successfully created skill."
    else
      @skill.errors.each{|attr,msg| puts "#{attr} - #{msg}" }
      render :action => 'new'
      flash[:notice] = "failed"
    end
  end

  def edit
  end

  def update
    if @skill.update_attributes(params[:skill])
      redirect_to @skill, :notice  => "Successfully updated skill."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @skill.destroy
    redirect_to skills_url, :notice => "Successfully destroyed skill."
  end
  
  private
  def skill_params
    params.require(:skill).permit(:name, :description,
  :skill_type_id, :properties, :teachers_title, :necessary_resources, :level, 
  :required_experience,:price, :start_date, :min_students, :max_students, :activity_duration,
  :location_id, :user_id, :location_attributes => [:address, :street_address, :post_code], skillimage_attributes: :attachment)
  end
  
  def set_skill
    @skill = Skill.find(params[:id])
  end
  
end
