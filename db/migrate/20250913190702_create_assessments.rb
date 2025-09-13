class CreateAssessments < ActiveRecord::Migration[8.0]
  def change
    create_table :assessments do |t|
      t.string :title
      t.jsonb :questions
      t.integer :passing_score
      t.integer :time_limit
      t.integer :course_id

      t.timestamps
    end
  end
end
