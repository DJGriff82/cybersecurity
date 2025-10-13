class DropTrainingModulePages < ActiveRecord::Migration[8.0]
  def change
    drop_table :training_module_pages
  end
end
