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

  def conversations
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

    # We then listed not assigned
    if current_user.category == "volunteer"
      @not_assigned_requests = Request.where(status: "not_assigned")
    else
      @not_assigned_requests = current_user.requests.where(status: "not_assigned")
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

  def update
    @request = Request.find(params[:id])
    @refugee_name = @request.refugee.first_name
    if @request.update(request_params)
      if params[:request][:status] == 'pending'
        @first_message = Message.create(request: @request, user: current_user, content: "Hi #{@refugee_name}, I'm taking your request, I'll be back to you soon.")
      end
      redirect_to conversations_path
    else
      render :index, flash: "Error when updating #{@refugee_name}'s request!"
    end
  end

  private

  def request_params
    params.require(:request).permit(:content, :category, :status)
  end
end
