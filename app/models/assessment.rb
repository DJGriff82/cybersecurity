
class Assessment < ApplicationRecord
  belongs_to :course

  validates :title, :passing_score, :time_limit, presence: true
  validates :passing_score, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :time_limit, numericality: { only_integer: true, greater_than: 0 }

  store_accessor :questions, :question_text, :options, :correct_answer, :points

  def total_points
    questions.sum { |q| q['points'].to_i }
  end
end