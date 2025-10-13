# app/models/course.rb
class Course < ApplicationRecord
  # Associations
  belongs_to :creator, class_name: "User", foreign_key: "created_by"
  belongs_to :category, optional: true
  belongs_to :company, optional: true

  has_many :training_modules, -> { order(:position) }, dependent: :destroy
  has_many :assessments, dependent: :destroy

  # Validations
  validates :title, :description, :duration, :difficulty, presence: true

  # Enum for difficulty levels
  enum :difficulty, {
    beginner: 0,
    intermediate: 1,
    advanced: 2
  }, default: :beginner

  # Scopes
  scope :active, -> { where(is_active: true) }
  scope :by_category, ->(category_id) { where(category_id: category_id) }
end