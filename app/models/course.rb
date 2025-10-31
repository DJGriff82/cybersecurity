class Course < ApplicationRecord
  # --- Direct associations used by controllers/views ---
  # Make creator optional so legacy/null rows don't crash reads in production
  belongs_to :creator,  class_name: "User", foreign_key: "created_by", optional: true
  belongs_to :category, optional: true
  belongs_to :company,  optional: true

  # --- Many-to-many (kept for compatibility if you link multiple companies) ---
  has_many :company_courses, dependent: :destroy
  has_many :companies, through: :company_courses

  # --- Related content ---
  has_many :training_modules, -> { order(:position) }, dependent: :destroy
  has_many :assessments, dependent: :destroy

  # --- Validations ---
  validates :title, :description, :duration, :difficulty, presence: true

  # --- Enum ---
  # IMPORTANT: your DB column `courses.difficulty` is a STRING.
  # Use a string-backed enum so Rails maps "beginner"/"intermediate"/"advanced" correctly.
  enum :difficulty, {
    beginner:     "beginner",
    intermediate: "intermediate",
    advanced:     "advanced"
  }, default: "beginner"

  # --- Scopes ---
  scope :active, -> { where(is_active: true) }
  scope :by_category, ->(category_id) { where(category_id: category_id) }
end
