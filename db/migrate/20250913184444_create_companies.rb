class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :subdomain
      t.string :contact_email
      t.string :subscription_status
      t.integer :max_users

      t.timestamps
    end
  end
end
