class ModulePage < ApplicationRecord
  belongs_to :training_module

  has_one_attached :image
  has_one_attached :video

  validates :title, :content, :order, presence: true
  validates :order, numericality: { only_integer: true }
end