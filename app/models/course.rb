class Course < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'created_by'
  belongs_to :category, optional: true
  belongs_to :company, optional: true  # Add this line
  has_many :training_modules, -> { order(:order) }, dependent: :destroy
  has_many :assessments, dependent: :destroy

  validates :title, :description, :duration, :difficulty, presence: true
  enum :difficulty, {
    beginner: 0,
    intermediate: 1, 
    advanced: 2
  }, default: :beginner

  scope :active, -> { where(is_active: true) }
  scope :by_category, ->(category_id) { where(category_id: category_id) }
end