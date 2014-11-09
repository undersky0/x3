class Profile < ActiveRecord::Base
  searchkick word_start: [:firstname]
  
  #after_save :reindex
  # before_destroy :remove_from_soulmate
  belongs_to :user

  
  attr_accessible :firstname, :lastname, :age, :website, :phoneNo, :profile_id, :actor_id, :name
  
  # def search_data
    # {
      # firstname: firstname,
      # lastname: lastname
    # }
  # end
  
  # def reindex
    # self.reindex
  # end

  # def add_to_soulmate
    # loader = Soulmate::Loader.new("profile")
    # loader.add("term" => "#{self.firstname} #{self.lastname}", "id" => self.id, "firstname" => self.firstname, "lastname" => self.lastname)
  # end
#   
   # def remove_from_soulmate
    # loader = Soulmate::Loader.new("profile")
    # loader.remove("id" => self.id)
  # end

end
