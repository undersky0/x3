class MembershipsController < ApplicationController
  

    def create
    @membership = current_user.memberships.build(:group_id => params[:group_id])
    if  current_user.memberships.find_by_group_id(params[:group_id]).nil?
      @membership.save
      flash[:notice] = "Joined Group"
      redirect_to groups_path

    else
      flash[:error] = "unable to join"
      redirect_to groups_path
    end
  end
  
  def destroy
    @membership = current_user.memberships.find_by_group_id(params[:id])
    @membership.destroy
    flash[:notice] = "Group removed"
    redirect_to groups_path
  end
end
