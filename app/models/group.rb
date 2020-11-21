class Group < ApplicationRecord
  has_many :event_details
  has_many :users
end
