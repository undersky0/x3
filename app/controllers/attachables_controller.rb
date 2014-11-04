class AttachablesController < ApplicationController
  def index
    @attachables = Attachables.all
  end

  def show
    @attachables = Attachables.find(params[:id])
  end

  def new
    @attachables = Attachables.new
  end

  def create
    @attachables = Attachables.new(params[:attachables])
    if @attachables.save
      redirect_to @attachables, :notice => "Successfully created attachables."
    else
      render :action => 'new'
    end
  end

  def edit
    @attachables = Attachables.find(params[:id])
  end

  def update
    @attachables = Attachables.find(params[:id])
    if @attachables.update_attributes(params[:attachables])
      redirect_to @attachables, :notice  => "Successfully updated attachables."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @attachables = Attachables.find(params[:id])
    @attachables.destroy
    redirect_to attachables_url, :notice => "Successfully destroyed attachables."
  end
end
