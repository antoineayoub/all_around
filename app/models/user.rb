class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Associations
  has_many :messages
  has_many :requests, class_name: 'Request', foreign_key: :refugee_id
  has_many :tickets, class_name: 'Request', foreign_key: :volunteer_id
  has_many :user_languages
end
