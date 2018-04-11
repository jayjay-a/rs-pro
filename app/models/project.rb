class Project < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :project_notes, dependent: :destroy
  has_many :material_lists, dependent: :destroy
  has_many :rental_lists, dependent: :destroy
  has_many :tasks, through: :jobs
  has_many :materials, through: :material_lists
  has_many :rental_equipments, through: :rental_lists
  belongs_to :customer
  belongs_to :project_status
  belongs_to :project_type

  #removed validation for presence  cause the belongs_to for the models already validates
  validates :bid_submit_date, presence: true
  validates :bid_material_cost, allow_nil: true, numericality: { greater_than_or_equal_to: 0, message: 'has to be 0 or greater' }
  validates :bid_cost_of_labor, allow_nil: true, numericality: { greater_than_or_equal_to: 0, message: 'has to be 0 or greater' }
  validates :bid_cost_of_permits, allow_nil: true, numericality: { greater_than_or_equal_to: 0, message: 'has to be 0 or greater' }
  validates :bid_equipment_rental, allow_nil: true, numericality: { greater_than_or_equal_to: 0, message: 'has to be 0 or greater' }
  validates :bid_freight, allow_nil: true, numericality: { greater_than_or_equal_to: 0, message: 'has to be 0 or greater' }
  validates :applicable_tax, allow_nil: true, numericality: { greater_than_or_equal_to: 0, message: 'has to be 0 or greater' }
  validates :bid_fuel_cost, allow_nil: true, numericality: { greater_than_or_equal_to: 0, message: 'has to be 0 or greater' }
  validates :bid_lodging_cost, allow_nil: true, numericality: { greater_than_or_equal_to: 0, message: 'has to be 0 or greater' }
  validates :bid_amount, allow_nil: true, numericality: { greater_than_or_equal_to: 0, message: 'has to be 0 or greater' }
  validate :project_start_date_cannot_be_before_bid_submit_date, unless: -> { project_start_date.blank? }
  validate :project_end_date_cannot_be_before_project_start_date, unless: -> { project_end_date.blank? }

  # cocoon
  accepts_nested_attributes_for :jobs, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :project_notes, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :material_lists, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :rental_lists, allow_destroy: true, reject_if: :all_blank

  def project_and_customer_and_branch
    "#{project_id} - #{customer.customer_name} #{customer.customer_branch}"
  end

  def project_start_date_cannot_be_before_bid_submit_date
    if bid_submit_date.present? && project_start_date < bid_submit_date
      errors.add(:project_start_date, 'can\'t be before the bid submit date')
    elsif bid_submit_date.blank? && project_start_date.present?
      errors.add(:project_start_date, 'can\'t exist without a bid submit date')
    end
  end

  def project_end_date_cannot_be_before_project_start_date
      if project_start_date.present? && project_end_date < project_start_date
        errors.add(:project_end_date, 'can\'t be before the project starts')
      elsif project_start_date.blank? && project_end_date.present?
        errors.add(:project_end_date, 'can\'t exist without a project start date')
      end
  end
end
