class RequestsController < ApplicationController

  def index
    if current_user.category == "volunteer"
      @not_assigned_requests = Request.where(status: "not_assigned")
      @pending_requests = current_user.tickets.where(status: 'pending')
      @solved_requests = current_user.tickets.where(status: 'solved')
    else
      @not_assigned_requests = current_user.requests.where(status: "not_assigned")
      @pending_requests = current_user.requests.where(status: 'pending')
      @solved_requests = current_user.requests.where(status: 'solved')
    end
  end


  def index
    # Conversation means request pending or solved
    @conversations = current_user.conversations
    if params[:conversation_id]
      @selected_conversation = @conversations.find(params[:conversation_id])
    else
      @selected_conversation = @conversations.first
    end
    @unread_messages = @selected_conversation.unread_messages(current_user)
    @unread_messages.each { |message| message.mark_as_read }
    @unread_conversations_count = current_user.unread_conversations_count

    # We then listed not assigned
    if current_user.category == "volunteer"
      @not_assigned_requests = Request.where(status: "not_assigned")
    else
      @not_assigned_requests = current_user.requests.where(status: "not_assigned")
    end
  end
end
