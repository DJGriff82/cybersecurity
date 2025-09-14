class CreateModulePages < ActiveRecord::Migration[8.0]
  def change
    create_table :module_pages do |t|
      t.references :training_module, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.integer :order

      t.timestamps
    end
  end
end
