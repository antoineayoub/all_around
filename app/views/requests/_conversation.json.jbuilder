json.extract! conversation, :id, :updated_at, :created_at

json.volunteer do
  json.id conversation.volunteer.id
  json.first_name conversation.volunteer.first_name
  json.gender conversation.volunteer.gender
  json.age conversation.volunteer.age
  end

  json.refugee do
    json.first_name conversation.refugee.first_name
    json.gender conversation.refugee.gender
    json.age conversation.refugee.age
    json.country_of_origin conversation.refugee.country_of_origin
    json.country_of_origin conversation.refugee.country_of_origin
    json.arrival_date conversation.refugee.arrival_date
  end

# json.other_user_piture_url conversation.other_user(current_user).avatar_url
json.other_user_first_name conversation.other_user(current_user).first_name
json.last_message_created_at conversation.last_message.created_at.strftime("%b %e")
json.last_message_content conversation.last_message.content
json.last_message_read_at conversation.last_message.read_at
json.is_last_message_writer_current_user conversation.last_message.user == current_user
