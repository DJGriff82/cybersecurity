class CompanyCourse < ApplicationRecord
  belongs_to :company
  belongs_to :course
end