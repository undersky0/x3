class ConversationsController < ApplicationController
    helper_method :mailbox, :conversation
    before_filter :check_conversations, :only => [:show]
  def index
    @conversations ||= current_user.mailbox.inbox.page(params[:page]).per(15)
    @unread = current_user.mailbox.inbox.page(params[:page]).per(15)
    @sentbox = current_user.mailbox.sentbox.page(params[:page]).per(15)
    @trash ||= current_user.mailbox.trash.page(params[:page]).per(15)
  end
  
  def show
    @receipts = current_user.mailbox.receipts_for(@conversation)
    render :action => :show
  end
  
  def reply
    @conversation = current_user.mailbox.conversations.find(params[:id])
    
    conversation = current_user.reply_to_conversation(@conversation, *message_params(:body))
    redirect_to :conversation
  end
  
  def trashbin
    @trash ||= current_user.mailbox.trash.all
  end
  def trash
   if params[:id].nil?
     redirect_to :back
     flash[:notice] = "No messages selected"
   else
      params[:id].each do |id| 
        @conversation = current_user.mailbox.conversations.find(id.to_i)
        @conversation.move_to_trash(current_user)
      end
  redirect_to :conversations
    end
  end
  
  def untrash
   if params[:id].nil?
     redirect_to :back
     flash[:notice] = "No messages selected"
   else
    params[:id].each do |id| 
       @conversation = current_user.mailbox.conversations.find(id.to_i)
       @conversation.untrash(current_user)
       redirect_to :back
      end
    end
  end
  
  def empty_trash
    current_user.mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).mark_as_deleted
    end
    redirect_to conversations_path
  end
  
  def mailbox
    @mailbox ||= current_user.mailbox
  end
  
  def converstion
    @conversation ||= mailbox.conversation.find(params[:id])
  end
  
  def conversation_params(*keys)
    fetch_params(:conversation, *keys)
  end

  def message_params(*keys)
    fetch_params(:message, *keys)
  end

  def fetch_params(key, *subkeys)
    params[key].instance_eval do
      case subkeys.size
      when 0 then self
      when 1 then self[subkeys.first]
      else subkeys.map{|k| self[k] }
      end
    end
  end
  
  private
  
  def check_conversations
    @conversation = current_user.mailbox.conversations.find(params[:id])
    if @conversation.nil? or !@conversation.is_participant?(current_user)
      redirect_to conversation_path
    end
    return
  end
  
end