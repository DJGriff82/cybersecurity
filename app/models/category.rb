
# app/models/category.rb
class Category < ApplicationRecord
  has_many :courses, dependent: :nullify
  
  validates :name, presence: true, uniqueness: true
  
  scope :active, -> { where(is_active: true) }
  scope :with_courses, -> { joins(:courses).where(courses: { is_active: true }).distinct }
end