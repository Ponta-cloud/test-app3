class ServiceUser < ApplicationRecord
    belongs_to :group, optional: true
    validates :name,     {presence: true}
    validates :password, {presence: true}
end
