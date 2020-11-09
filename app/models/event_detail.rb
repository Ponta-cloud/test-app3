class EventDetail < ApplicationRecord
  belongs_to :group
  validates :event_title, presence: true
end
