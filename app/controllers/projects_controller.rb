class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [ :index, :new, :edit, :show, :destroy]
  before_action :set_skills, only: [:new, :edit]
  #before_action :set_friend, only: [:new]
  respond_to :html

  def index
    @projects = @user.projects
    respond_with(@projects)
  end

  def show
    respond_with(@project)
  end

  def new
    @project = @user.projects.new
    respond_with(@project)
  end

  def edit
    @skills = @user.skills
  end

  def create
    @project = current_user.projects.build(project_params)
    flash[:notice] = "New project has been created!" if @project.save
    respond_with(current_user,@project )
  end

  def update
    @project.update(project_params)
    flash[:notice] = "Project has been updated" if @project.save
    respond_with(current_user, @project)
  end

  def destroy
    @project.destroy
    respond_with(@user) do |format|
      format.html {redirect_to user_projects_path(@user), notice: "Project has been deleted"}
    end
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :about, :user_id, :skill_id, projectimage_attributes: :attachment)
    end
    
    def set_user
       @user = User.find(params[:user_id])
    end
    def set_friend
       @user = User.find(params[:friend_id])
    end
    
    def set_skills
    #combines skills associated with user from multiple dbs - later more will need to be added
    @skills = current_user.skills
    u = current_user.invites.joined
      u.each do |p|
        s = Skill.find_by_id(p.inviteable_id)
        @skills << s
      end     
    end
    
end
