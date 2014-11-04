class Group::Igroupcover < Asset
 has_attached_file :attachment, :styles => { :gcover => "1078x286"}, 
  :default_url => "./images/default_avatar_:style.jpg"
end
