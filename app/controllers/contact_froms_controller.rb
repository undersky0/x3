class ContactFromsController < ApplicationController
  #before_action :set_contact_from

  respond_to :html

  def index
  end

  def new
    @contact_from = ContactFrom.new
    respond_with(@contact_from)
  end

  def create
    @contact_from = ContactFrom.new(contact_from_params)
    if @contact_from.deliver
      redirect_to 'home', :notice => 'Email has been sent.'
    else
      redirect_to root_path, :notice => 'Email could not be sent.'
    end
  end


  private
    def set_contact_from
      @contact_from = ContactFrom.find(params[:id])
    end

    def contact_from_params
      params.require(:contact_from).permit(:name, :email, :messge, :message_title)
    end
end
