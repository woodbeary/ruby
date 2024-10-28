class Incident < ApplicationRecord
  belongs_to :user
  belongs_to :priority_changed_by, class_name: 'User', optional: true
  
  validates :title, presence: true
  validates :submitted_priority, presence: true
  
  # Add any other validations or relationships you need
end
