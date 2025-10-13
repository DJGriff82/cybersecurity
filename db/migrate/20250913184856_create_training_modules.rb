class CreateTrainingModules < ActiveRecord::Migration[8.0]
  def change
    create_table :training_modules do |t|
      t.string :title
      t.text :content
      t.string :video_url
      t.integer :course_id
      t.integer :order

      t.timestamps
    end
  end
end
