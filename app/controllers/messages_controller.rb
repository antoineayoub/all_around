class MessagesController < ApplicationController
  def create
    @selected_conversation = Request.find(params[:request_id])
    @message = Message.new(message_params)
    @message.user = current_user
    @message.request = @selected_conversation
    @message.save
    @requests = current_user.conversations.includes(:messages).order("messages.created_at DESC")
  end

  private

  def message_params
    params.require(:message).permit(:content, :request_id)
  end
end
