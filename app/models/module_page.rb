class ModulePage < ApplicationRecord
  belongs_to :training_module

  validates :title, :content, :order, presence: true
  validates :order, numericality: { only_integer: true }

  default_scope { order(:order) }
end