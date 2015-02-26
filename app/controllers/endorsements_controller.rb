class EndorsementsController < ApplicationController
  before_action :set_endorsement, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [ :index, :edit, :show, :destroy]
  before_action :set_endorser, only: [ :new]

  respond_to :html, :js

  def index
    @endorsements = @user.inverse_endorsements
    respond_with(@endorsements)
  end

  def show
    respond_with(@endorsement)
  end

  def new
    @endorsement = current_user.endorsements.new
    respond_with(@endorsement)
  end

  def edit
  end

  def create
    @endorsements = Endorsement.all
    @endorsement = current_user.endorsements.build(endorsement_params)
    @endorsement.endorser_id = params[:user_id]
    @endorsement.save
    respond_with(@endorsement)
  end

  def update
    @endorsements = Endorsement.all
    @endorsement.update(endorsement_params)
    respond_with(@endorsement)
  end

  def destroy
    @endorsements = Endorsement.all
    @endorsement.destroy
    respond_with(@endorsement)
  end

  private
    def set_user
       @user = User.find(params[:user_id])
    end
    def set_endorser
       @endorser = User.find(params[:endorser_id])
    end
    
    def set_endorsement
      @endorsement = Endorsement.find(params[:id])
    end

    def endorsement_params
      params.require(:endorsement).permit(:message, :user_id, :endorser_id)
    end
end
