if @selected_conversation
  json.request_id @selected_conversation.id
  json.first_name @selected_conversation.other_user(current_user).first_name

  json.conversations do
    json.array! @conversations do |conversation|
      json.partial! "requests/conversation", conversation: conversation
    end
  end

  json.messages do
    json.array! @selected_conversation.messages.sort_by(&:created_at) do |message|
      json.partial! "requests/message", message: message
    end
  end
end
