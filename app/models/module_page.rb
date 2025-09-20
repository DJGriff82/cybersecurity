class ModulePage < ApplicationRecord
  belongs_to :training_module

  has_one_attached :image
  has_one_attached :video

  validates :title, :content, :position, presence: true
  validates :position, numericality: { only_integer: true }

  default_scope { order(:position) }
end