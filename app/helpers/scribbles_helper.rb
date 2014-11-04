module ScribblesHelper
  def toggle_promote_button(scribble, user)
  if user.flagged?(scribble, :promote)
    link_to "demote", promote_scribble_path(scribble)
  else
    link_to "promote", promote_scribble_path(scribble)
  end
  end
  
end
