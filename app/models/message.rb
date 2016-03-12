class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :request

  validates :content, :request, presence: true
  validates :user, inclusion: { in: :users }

  def mark_as_read
    self.read_at = DateTime.now
    self.save
  end

  def users
    request.users
  end
end
