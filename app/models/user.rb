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

  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, :age, :address, :arrival_date, :country_of_origin, presence: true
  validates :gender, presence: true, inclusion: { in: ['male', 'female'] }
  validates :phone, presence: true # TO DO REGEXP, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :country_of_origin, inclusion: { in: COUNTRIES }

  accepts_nested_attributes_for :user_languages, allow_destroy: true, reject_if: :all_blank
end
