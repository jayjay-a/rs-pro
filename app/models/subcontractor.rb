class Subcontractor < ApplicationRecord
    has_many :assignments
    belongs_to :subcontractor_statuses
end