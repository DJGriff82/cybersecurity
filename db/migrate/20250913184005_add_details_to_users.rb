class AddDetailsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :role, :integer, default: 0
    add_column :users, :company_id, :integer
    add_column :users, :deleted_at, :datetime
    
    add_index :users, :company_id
    add_index :users, :deleted_at
    add_index :users, :role
  end
end