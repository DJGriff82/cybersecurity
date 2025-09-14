class RemoveContentAndOrderFromTrainingModules < ActiveRecord::Migration[8.0]
  def change
    remove_column :training_modules, :content, :text
    remove_column :training_modules, :order, :integer
  end
end
