class TrainingModule < ApplicationRecord
  belongs_to :course
  has_many :user_progresses, dependent: :destroy

  validates :title, :content, :order, presence: true
  validates :order, numericality: { only_integer: true }

  default_scope { order(:order) }
end