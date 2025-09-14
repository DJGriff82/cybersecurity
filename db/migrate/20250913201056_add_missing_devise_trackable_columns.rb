# db/migrate/xxx_add_missing_devise_trackable_columns.rb
class AddMissingDeviseTrackableColumns < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :sign_in_count, :integer, default: 0, null: false unless column_exists?(:users, :sign_in_count)
    add_column :users, :current_sign_in_at, :datetime unless column_exists?(:users, :current_sign_in_at)
    add_column :users, :last_sign_in_at, :datetime unless column_exists?(:users, :last_sign_in_at)
    add_column :users, :current_sign_in_ip, :string unless column_exists?(:users, :current_sign_in_ip)
    add_column :users, :last_sign_in_ip, :string unless column_exists?(:users, :last_sign_in_ip)
  
    # Also add first_name and last_name if they're still missing
    unless column_exists?(:users, :first_name)
      add_column :users, :first_name, :string
    end
    
    unless column_exists?(:users, :last_name)
      add_column :users, :last_name, :string
    end
    
    unless column_exists?(:users, :company_id)
      add_column :users, :company_id, :integer
    end
    
    unless column_exists?(:users, :deleted_at)
      add_column :users, :deleted_at, :datetime
    end
  end
end