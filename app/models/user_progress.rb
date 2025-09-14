# app/models/user_progress.rb
class UserProgress < ApplicationRecord
  belongs_to :user
  belongs_to :training_module

  # Modern enum syntax
  enum :status, {
    not_started: 0,
    in_progress: 1,
    completed: 2
  }

  validates :user_id, uniqueness: { scope: :training_module_id }
  validates :score, numericality: { 
    only_integer: true, 
    greater_than_or_equal_to: 0, 
    less_than_or_equal_to: 100 
  }, allow_nil: true
end