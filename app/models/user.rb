class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  COUNTRIES = ['Syria', 'Irak', 'Soudan', 'Somalia']
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Associations
  has_many :messages
  has_many :requests, class_name: 'Request', foreign_key: :refugee_id
  has_many :tickets, class_name: 'Request', foreign_key: :volunteer_id
  has_many :user_languages
  has_many :languages, through: :user_languages

  validates :category, presence: true
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  validate :validate_specific_fields, on: [:create]

  accepts_nested_attributes_for :user_languages, allow_destroy: true, reject_if: :all_blank

  def validate_specific_fields
    raise
    if category == 'refugee'
      errors[:base] << "Must set age" unless age
      errors[:base] << "Must set gender" unless gender
      errors[:base] << "Must set address" unless address
      errors[:base] << "Must set country_of_origin" unless COUNTRIES.include?(country_of_origin)
      errors[:base] << "Must set arrival_date" unless ['male', 'female'].include?(arrival_date)
      errors[:base] << "Must set phone" unless phone #
    end
  end

  def conversations
    Request.where(status:['pending', 'solved']).includes(:messages)
                .where("refugee_id = :id OR volunteer_id = :id", id: id)
                .order("messages.created_at DESC")
  end

  def other_user(conversation)
    conversation.users.include?(self) ? conversation.other_user(self) : nil
  end

  def unread_conversations
    conversations.select { |c| c.unread_messages?(self) }
  end

  def unread_conversations_count
    unread_conversations.count
  end

  def unread_conversations?
    unread_conversations_count > 0
  end

  # def one_avatar_url
  #   avatar_url ? avatar_url : "http://placehold.it/64x64"
  # end
end
