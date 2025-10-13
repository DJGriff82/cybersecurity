# db/migrate/xxx_complete_user_columns.rb
class CompleteUserColumns < ActiveRecord::Migration[8.0]
  def change
    # First, check what columns exist
    columns_to_add = []
    
    # List all required columns
    required_columns = [
      [:first_name, :string],
      [:last_name, :string], 
      [:company_id, :integer],
      [:deleted_at, :datetime],
      [:sign_in_count, :integer, { default: 0, null: false }],
      [:current_sign_in_at, :datetime],
      [:last_sign_in_at, :datetime],
      [:current_sign_in_ip, :string],
      [:last_sign_in_ip, :string]
    ]
    
    # Add each missing column
    required_columns.each do |column_name, type, options = {}|
      unless column_exists?(:users, column_name)
        if options.any?
          add_column :users, column_name, type, **options
        else
          add_column :users, column_name, type
        end
        puts "Added column: #{column_name}"
      else
        puts "Column already exists: #{column_name}"
      end
    end
    
    # Add indexes
    add_index :users, :company_id unless index_exists?(:users, :company_id)
    add_index :users, :deleted_at unless index_exists?(:users, :deleted_at)
    add_index :users, :role unless index_exists?(:users, :role)
  end
end