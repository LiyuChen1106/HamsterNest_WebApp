class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.integer :category_id
      t.string :category_name
      t.string :item_name
      t.integer :itemid

      t.timestamps
    end
  end
end
