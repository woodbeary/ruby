class User < ApplicationRecord
  has_many :incidents
  has_many :priority_changed_incidents, class_name: 'Incident', foreign_key: 'priority_changed_by_id'

  validates :email, presence: true, uniqueness: true
end 