class RequestsController < ApplicationController

  def index
    # Conversation means request pending or solved
    @conversations = current_user.conversations
    if params[:request_id]
      @selected_conversation = @conversations.find(params[:request_id])
    else
      @selected_conversation = @conversations.first
    end
    if @selected_conversation
      @unread_messages = @selected_conversation.unread_messages(current_user)
      @unread_messages.each { |message| message.mark_as_read }
      @unread_conversations_count = current_user.unread_conversations_count
    end
  end

  def tickets
    # We then listed not assigned
    if current_user.category == "volunteer"
      @solved_tickets = current_user.tickets.where(status: "solved")
      @pending_tickets = current_user.tickets.where(status: "pending")
      @not_assigned_tickets = Request.where(status: "not_assigned")
    else
      redirect_to requests_path
    end
  end

  def new
    @category = params[:category]
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    @request.refugee = current_user
    @request.status = 'not assigned'
    if @request.save
      redirect_to requests_path
    else
      @category = params[:request][:category]
      render :new
    end
  end

  private

  def request_params
    params.require(:request).permit(:content, :category)
  end
end
