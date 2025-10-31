class Course < ApplicationRecord
  belongs_to :creator,  class_name: "User", foreign_key: "created_by", optional: true
  belongs_to :category, optional: true
  belongs_to :company,  optional: true

  has_many :company_courses, dependent: :destroy
  has_many :companies, through: :company_courses

  has_many :training_modules, -> { order(:position) }, dependent: :destroy
  has_many :assessments, dependent: :destroy

  validates :title, :description, :duration, :difficulty, presence: true

  # SIMPLE ENUM THAT WORKS:
  enum difficulty: [:beginner, :intermediate, :advanced]

  scope :active, -> { where(is_active: true) }
  scope :by_category, ->(category_id) { where(category_id: category_id) }

  def category_name
    category&.name || "Uncategorized"
  end

  def company_name
    company&.name || "No Company"
  end

  def creator_name
    creator&.full_name || creator&.email || "Unknown"
  end
end