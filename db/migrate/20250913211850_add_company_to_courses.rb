# db/migrate/xxx_add_company_to_courses.rb
class AddCompanyToCourses < ActiveRecord::Migration[8.0]
  def change
    add_column :courses, :company_id, :integer
    add_index :courses, :company_id
  end
end