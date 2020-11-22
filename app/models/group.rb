class Group < ApplicationRecord
  has_many :event_details
  has_many :service_users
end
