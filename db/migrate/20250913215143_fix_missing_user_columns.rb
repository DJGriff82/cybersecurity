# db/migrate/xxx_fix_missing_user_columns.rb
class FixMissingUserColumns < ActiveRecord::Migration[8.0]
  def change
    # Add missing columns only if they don't exist
    add_column :users, :first_name, :string unless column_exists?(:users, :first_name)
    add_column :users, :last_name, :string unless column_exists?(:users, :last_name)
    add_column :users, :company_id, :integer unless column_exists?(:users, :company_id)
    add_column :users, :deleted_at, :datetime unless column_exists?(:users, :deleted_at)
    
    # Add Devise trackable columns only if they don't exist
    add_column :users, :sign_in_count, :integer, default: 0, null: false unless column_exists?(:users, :sign_in_count)
    add_column :users, :current_sign_in_at, :datetime unless column_exists?(:users, :current_sign_in_at)
    add_column :users, :last_sign_in_at, :datetime unless column_exists?(:users, :last_sign_in_at)
    add_column :users, :current_sign_in_ip, :string unless column_exists?(:users, :current_sign_in_ip)
    add_column :users, :last_sign_in_ip, :string unless column_exists?(:users, :last_sign_in_ip)
    
    # Add indexes only if they don't exist
    add_index :users, :company_id unless index_exists?(:users, :company_id)
    add_index :users, :deleted_at unless index_exists?(:users, :deleted_at)
    add_index :users, :role unless index_exists?(:users, :role)
  end
end