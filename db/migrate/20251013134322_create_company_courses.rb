class CreateCompanyCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :company_courses do |t|
      t.references :company, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
