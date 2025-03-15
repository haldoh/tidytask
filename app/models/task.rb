class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :completed, inclusion: { in: [true, false] }

  # Default scope to only show non-deleted tasks
  default_scope -> { where(deleted_at: nil) }

  # Explicit scope for active tasks
  scope :active, -> { where(deleted_at: nil) }

  # Method to perform soft delete
  def soft_delete
    update(deleted_at: Time.current)
  end
end
