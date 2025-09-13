
class Course < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'created_by'
  has_many :training_modules, -> { order(:order) }, dependent: :destroy
  has_many :assessments, dependent: :destroy

  validates :title, :description, :duration, presence: true
  enum difficulty: { beginner: 0, intermediate: 1, advanced: 2 }

  scope :active, -> { where(is_active: true) }
end