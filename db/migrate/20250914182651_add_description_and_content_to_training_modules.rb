class AddDescriptionAndContentToTrainingModules < ActiveRecord::Migration[8.0]
  def change
    add_column :training_modules, :description, :text
   
  end
end
