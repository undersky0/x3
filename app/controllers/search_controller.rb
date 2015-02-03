class SearchController < ApplicationController
  def index
  end
  
  def query
    search = Profile.search(params[:q], fields: [{firstname: :word_start}, :lastname], misspellings: true, limit: 3)
    skillsearch = Skill.search(params[:q], fields: [{name: :word_start}], misspellings: true, limit:3)
    respond_to do |format|
      format.json do
        profile = search.map do |profiles|
        if profiles.user.location.nil?
          {name: profiles.firstname.to_s.truncate(16) + " " + profiles.lastname.to_s.truncate(16), id: profiles.user_id, avatar: profiles.user.useravatar.url(:tiny), city: "Somewhere"}
        else
          {name: profiles.firstname.to_s.truncate(16) + " " + profiles.lastname.to_s.truncate(16), id: profiles.user_id, avatar: profiles.user.useravatar.url(:tiny), city: profiles.user.location.city}
        end
      end
      skillresults = skillsearch.map do |skills|
        {sname: skills.name.to_s.truncate(20), tname: skills.user.full_name, skillimage: skills.skillimage.url(:tiny), sid: skills.id}
      end
      results = {user: profile, skill: skillresults }
      render json: results
    end
  end
  end
  
  def tokenquery
    search = Profile.search(params[:q], fields: [{firstname: :word_start}, :lastname], misspellings: true, limit: 5)
    respond_to do |format|
      format.json do
        profile = search.map do |profiles|
          {name: profiles.firstname.to_s.truncate(16) + " " + profiles.lastname.to_s.truncate(16), id: profiles.user_id}
        end
      results = {users: profile }
      render json: results
      end
  end
end
end

