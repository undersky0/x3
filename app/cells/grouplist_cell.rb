class GrouplistCell < Cell::Rails
include Devise::Controllers::Helpers
    helper_method :current_user
  def show
    @group = Group.all
    @usergroups = current_user.groups
    @g = @usergroups + @group
    @groups = @g.uniq
    render
  end

end
