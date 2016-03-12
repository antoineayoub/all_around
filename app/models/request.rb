class Request < ActiveRecord::Base
  CATEGORIES = ["french", "transport", "food", "health", "hotel", "welcome", "drink", "legal"]
  belongs_to :refugee, class_name: 'User'
  belongs_to :volunteer, class_name: 'User'
  validates :category, inclusion: {in: CATEGORIES}

  has_many :messages
end
