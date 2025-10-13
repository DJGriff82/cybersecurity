class RenameOrderToPositionInModulePages < ActiveRecord::Migration[8.0]
 def change
    rename_column :module_pages, :order, :position
  end
end
