class RenameOrderToPositionInTrainingModules < ActiveRecord::Migration[8.0]
  def change
    rename_column :training_modules, :order, :position
  end
end
