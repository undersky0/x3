class SkillsController < ApplicationController
  def index
    sleep 1
    if params[:skill_id].present?
      @users = Skill.find(params[:skill_id])
       respond_to do |format|
         puts @users.id
          #format.html
          #format.html {render :partial => "skills/joined", :locals => {:users => @users}}
          format.js 
       end
    end
    @s = Skill.all
    @skills = Kaminari.paginate_array(@s).page(params[:page]).per(25)
    @skilltypes = SkillType.all
    @skill = User.all
    
    if params[:q].present?
      @s = Skill.search(params[:q], fields: [{name: :word_start}], misspellings: true, limit:3)
      @skills = Kaminari.paginate_array(@s).page(params[:page]).per(25)
    end
    
    if params[:id].present?
      @s = Skill.where(skill_type_id: params[:id])
      @skills = Kaminari.paginate_array(@s).page(params[:page]).per(25)
    end

    
  end

  def show
    @skill = Skill.find(params[:id])
    @location = @skill.location
    @distance_from = @location.distance_to(current_user.location)
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
    @skill = Skill.find(params[:id])
  end

  def update
    @skill = Skill.find(params[:id])
    if @skill.update_attributes(params[:skill])
      redirect_to @skill, :notice  => "Successfully updated skill."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @skill = Skill.find(params[:id])
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
  
end
