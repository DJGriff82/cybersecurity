class Course < ApplicationRecord
  belongs_to :creator,  class_name: "User", foreign_key: "created_by", optional: true
  belongs_to :category, optional: true
  belongs_to :company,  optional: true

  has_many :company_courses, dependent: :destroy
  has_many :companies, through: :company_courses

  has_many :training_modules, -> { order(:position) }, dependent: :destroy
  has_many :assessments, dependent: :destroy

  validates :title, :description, :duration, :difficulty, presence: true

  # STRING column in DB → STRING enum mapping:
  enum :difficulty, {
    beginner:     "beginner",
    intermediate: "intermediate",
    advanced:     "advanced"
  }, default: "beginner"

  scope :active, -> { where(is_active: true) }
  scope :by_category, ->(category_id) { where(category_id: category_id) }
end
