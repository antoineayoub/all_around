class Request < ActiveRecord::Base
  CATEGORIES = ["french", "transport", "food", "health", "hotel", "welcome", "drink", "legal"]
  belongs_to :refugee, class_name: 'User', foreign_key: :refugee_id
  belongs_to :volunteer, class_name: 'User', foreign_key: :volunteer_id
  validates :category, inclusion: {in: CATEGORIES}

  has_many :messages

  def users
    return [refugee, volunteer]
  end

  def other_user(user)
    users.include?(user) ? (users - [user]).first : nil
  end

  def unread_messages(user)
    messages.where(user: other_user(user), read_at: nil)
  end

  def unread_messages_count(user)
    unread_messages(user).count
  end

  def unread_messages?(user)
    unread_messages_count(user) > 0
  end

  def last_message
    messages.order(created_at: :asc).last
  end
end
