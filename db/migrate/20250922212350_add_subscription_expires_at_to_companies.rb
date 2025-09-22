class AddSubscriptionExpiresAtToCompanies < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :subscription_expires_at, :datetime
  end
end
