class UsersController < ApplicationController
    # GET /users
  # GET /users.js.coffee
autocomplete :profile, :first_name, :full => true, :extra_data => [:lastname]

  def user_skills
    @user = User.find(params[:id])
    @skills = @user.skills
  end
  def show
      @user = User.find(params[:id])
      @albumscover = @user.albums.last(2)
      @userskillscover = @user.skills.last(2)
      @all_connections = User.all
      @scribbled = @user
      @scribbles = Scribble.where(scribbled_type: "User", scribbled_id: @user.id).order("created_at DESC").page params[:page]
      # (1-@user.useravatar.count).times {@card.uploads.build}
      respond_to do |format|
        format.html
        format.json { render json:@user}
      end
      
  end

def usersearch
  case
  when params[:location].present? && params[:query].blank?
    @u = Location.users_city(params[:location])
    if @u.empty?
      @u = Location.users_city(current_user.location.city)
      @us = User.find([@u]).compact
    @users = Kaminari.paginate_array(@us).page(params[:page]).per(40)
    flash[:notice] = "No records found"
    else
    @us = User.find([@u]).compact
    @users = Kaminari.paginate_array(@us).page(params[:page]).per(40)
    end

  when params[:query].present? && params[:location].blank?
  @u = Profile.search(params[:query]).map(&:user_id)
  if @u.empty?
    @u = Location.users_city(current_user.location.city)
    @us = User.find([@u]).compact
    @users = Kaminari.paginate_array(@us).page(params[:page]).per(40)
    flash[:notice] = "No records found"
  else
  @us = User.find([@u]).compact
  @users = Kaminari.paginate_array(@us).page(params[:page]).per(10)
  end
  
  when params[:query].present? && params[:location].present?
      @u = Profile.search(params[:query]).map(&:user_id)     
      @l = Location.users_city(params[:location])
      if @u.empty? && @l.empty?
      @u = Location.users_city(current_user.location.city)
      @us = User.find([@u]).compact
      @users = Kaminari.paginate_array(@us).page(params[:page]).per(40)
      flash[:notice] = "No records found"
      elsif @u.empty? && !@l.empty?
            @us = User.find([@l]).compact
            @users = Kaminari.paginate_array(@us).page(params[:page]).per(40)
      elsif @l.empty? && !@u.empty?
        @us = User.find([@u]).compact
        @users = Kaminari.paginate_array(@us).page(params[:page]).per(10)
      else
      @us = User.find([@u]).compact
      @lo = User.find([@l]).compact
      @x = @us + @lo
      @s = User.find([@x])
      @users = Kaminari.paginate_array(@g).page(params[:page]).per(40)
      end
      

  else
    @u = Location.users_city(current_user.location.city)
    @us = User.find([@u]).compact
    @users = Kaminari.paginate_array(@us).page(params[:page]).per(40)
  end
  
      
end


  def showconnections
    @user = User.find(params[:id])
    @all_connections = User.all
    
      case
  when params[:location].present? && params[:query].blank?
    @u = Location.users_city(params[:location])
    if @u.empty?
      @u = Location.users_city(current_user.location.city)
      @us = User.find([@u]).compact
    @users = Kaminari.paginate_array(@us).page(params[:page]).per(40)
    flash[:notice] = "No records found"
    else
    @us = User.find([@u]).compact
    @users = Kaminari.paginate_array(@us).page(params[:page]).per(40)
    end

  when params[:query].present? && params[:location].blank?
  @u = Profile.search(params[:query]).map(&:user_id)
  if @u.empty?
    @u = Location.users_city(current_user.location.city)
    @us = User.find([@u]).compact
    @users = Kaminari.paginate_array(@us).page(params[:page]).per(40)
    flash[:notice] = "No records found"
  else
  @us = User.find([@u]).compact
  @users = Kaminari.paginate_array(@us).page(params[:page]).per(10)
  end
  
  when params[:query].present? && params[:location].present?
      @u = Profile.search(params[:query]).map(&:user_id)     
      @l = Location.users_city(params[:location])
      if @u.empty? && @l.empty?
      @u = Location.users_city(current_user.location.city)
      @us = User.find([@u]).compact
      @users = Kaminari.paginate_array(@us).page(params[:page]).per(40)
      flash[:notice] = "No records found"
      elsif @u.empty? && !@l.empty?
            @us = User.find([@l]).compact
            @users = Kaminari.paginate_array(@us).page(params[:page]).per(40)
      elsif @l.empty? && !@u.empty?
        @us = User.find([@u]).compact
        @users = Kaminari.paginate_array(@us).page(params[:page]).per(10)
      else
      @us = User.find([@u]).compact
      @lo = User.find([@l]).compact
      @x = @us + @lo
      @s = User.find([@x])
      @users = Kaminari.paginate_array(@g).page(params[:page]).per(40)
      end
  else
    @u = Location.users_city(current_user.location.city)
    @us = User.find([@u]).compact
    @users = Kaminari.paginate_array(@us).page(params[:page]).per(40)
  end
  end
  
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { render "crop" , flash[:notice]=>'Card was successfully updated.'} #redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { redirect_to @user }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def crop
    if params[:user].present?
      @user = User.find(params[:id])
            u = params[:user][:useravatar_attributes]
            old_upload = Asset.find(u[:id].gsub(/D/, '').to_i)
            if(old_upload)
              if(old_upload.update_attributes(u))
                old_upload.reprocess_pic
              end
            end
      respond_to do |format|
        if @user.update_attributes(params[:user])
        format.html { redirect_to @user, flash[:notice]=>'Card was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit", flash[:notice] => "Card was successfully updated." }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
  end
  else
     @user = User.find(params[:id])
    respond_to do |format|
        format.html { render "crop" , flash[:notice]=>'Card was successfully updated.'} #redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      end
    end
  end
  
  
  def index
    @user = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
    def autocomplete
    render json: Profile.search(params[:query], autocomplete: true, limit: 10).map(&:firstname)
  end
end
