class TrainingModule < ApplicationRecord
  belongs_to :course
  has_many :training_module_pages, -> { order(:order) }, dependent: :destroy
  has_many :user_progresses, dependent: :destroy

  validates :title, :order, presence: true
  validates :order, numericality: { only_integer: true }

  default_scope { order(:order) }
end