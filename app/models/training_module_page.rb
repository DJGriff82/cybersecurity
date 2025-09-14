class TrainingModule < ApplicationRecord
  belongs_to :course
  has_many :training_module_pages, -> { order(:order) }, dependent: :destroy

  validates :title, presence: true
end