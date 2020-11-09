class Group < ApplicationRecord
  has_many :event_details
  validates :group_name, presence: true
end
