class Request < ActiveRecord::Base
  belongs_to :refugee, class_name: 'User'
  belongs_to :volunteer, class_name: 'User'

  has_many :messages
end
