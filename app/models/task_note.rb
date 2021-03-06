class TaskNote < ApplicationRecord
  acts_as_paranoid #for soft deletes
  belongs_to :task

  # Validations
  validates :task_notes, presence: true, length: { maximum: 5000 }
  validates :task_note_owner, presence: true, length: { maximum: 70 }, format: { with: /\A[a-zA-Z'\-.\s]*\z/, message: 'can only be letters' }
  validates :task_note_date, presence: true
end
