class MessagesController < ApplicationController
  
  def new
    if params[:receiver].present?
      @recipient = User.find_by_slug(params[:receiver])
      return if @recipient.nil?
      @recipient = nil if User.normalize(@recipient)==User.normalize(current_user)
    end
      @message = current_user.messages.new
  end
  
  def create
    @recipients = 
      if params[:messages][:recipients].present?
        @recipients = params[:messages][:recipients].split(',').map{ |r| User.find(r) }
      else
        []
      end
    
    @receipt = current_user.send_message(@recipients, params[:messages][:body], params[:messages][:subject])
    if (@receipt.errors.blank?)
      @conversation = @receipt.conversation
      flash[:success]= "Message has been sent"
      redirect_to conversation_path(@conversation)
    else
      render :action => :new
    end
  end
  
  def show
    if @message = Message.find_by_id(params[:id]) and @conversation = @message.conversation
      if @conversation.is_participant?(current_user)
        redirect_to conversation_path(@conversation)
        return
        
      end
    end
    redirect_to conversation_path
  end
end
