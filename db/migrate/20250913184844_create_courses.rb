class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.integer :duration
      t.string :difficulty
      t.boolean :is_active
      t.integer :created_by

      t.timestamps
    end
  end
end
