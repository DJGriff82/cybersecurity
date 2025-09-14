cclass TrainingModule < ApplicationRecord
  belongs_to :course
  has_many :user_progresses, dependent: :destroy
  has_many :pages, -> { order(:order) }, dependent: :destroy

  validates :title, presence: true
end