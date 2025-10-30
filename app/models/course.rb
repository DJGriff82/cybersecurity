# app/models/course.rb
class Course < ApplicationRecord
  # --- Direct associations used by controllers/views ---
  belongs_to :creator,  class_name: "User", foreign_key: "created_by"         # required by default
  belongs_to :category, optional: true
  belongs_to :company,  optional: true    # <-- add this so includes(:company) and company_id work

  # --- Many-to-many (kept for compatibility if you link multiple companies) ---
  has_many :company_courses, dependent: :destroy
  has_many :companies, through: :company_courses

  # --- Related content ---
  has_many :training_modules, -> { order(:position) }, dependent: :destroy
  has_many :assessments, dependent: :destroy

  # --- Validations ---
  validates :title, :description, :duration, :difficulty, presence: true

  # --- Enum ---
  enum :difficulty, { beginner: 0, intermediate: 1, advanced: 2 }, default: :beginner

  # --- Scopes ---
  scope :active, -> { where(is_active: true) }
  scope :by_category, ->(category_id) { where(category_id: category_id) }
end
