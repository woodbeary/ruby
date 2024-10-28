class Incident < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true, inclusion: { in: %w[open in_progress resolved] }

  # Add any validations you need
  validates :submitted_priority, inclusion: { in: %w[P1 P2 P3 P4] }, allow_nil: true
  validates :final_priority, inclusion: { in: %w[P1 P2 P3 P4] }, allow_nil: true

  # Remove the enum and just use string validation for now
end
