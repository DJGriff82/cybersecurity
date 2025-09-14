class AddCategoryToCourses < ActiveRecord::Migration[8.0]
  def change
    add_column :courses, :category_id, :integer
  end
end
