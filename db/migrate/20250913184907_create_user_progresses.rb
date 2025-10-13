class CreateUserProgresses < ActiveRecord::Migration[8.0]
  def change
    create_table :user_progresses do |t|
      t.integer :user_id
      t.integer :training_module_id
      t.integer :status
      t.integer :score
      t.integer :time_spent
      t.datetime :completed_at

      t.timestamps
    end
  end
end
