class TrainingModule < ApplicationRecord
  belongs_to :course
  has_many :module_pages, -> { order(:position) }, dependent: :destroy
  has_many :user_progresses, dependent: :destroy

  validates :title, :position, presence: true
  validates :position, numericality: { only_integer: true }

  default_scope { order(:position) }
end