class Job < ApplicationRecord
  has_many :job_notes, dependent: :destroy
  has_many :tasks, dependent: :destroy
  belongs_to :project, optional: true
  belongs_to :job_type
  belongs_to :job_status

  validates :job_type_id, presence: true
  validates :job_status_id, presence: true
  validates :job_start_date, presence: true
  validate :job_end_date_cannot_be_before_job_start_date, unless: -> { job_end_date.blank? }

  #nested forms
  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :job_notes, allow_destroy: true, reject_if: :all_blank

  def job_and_type
    "#{job_id} - #{job_type.job_type_description}"
  end

  def job_end_date_cannot_be_before_job_start_date
     if job_start_date.present? && job_end_date < job_start_date
       errors.add(:job_end_date, "can't be before the Job Start Date")
     elsif job_end_date.present? && job_start_date.blank?
       errors.add(:job_end_date, "can't exist without a Job Start Date")
     end
  end

end
