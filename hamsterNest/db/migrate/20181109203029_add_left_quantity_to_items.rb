class AddLeftQuantityToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :left_quantity, :integer
  end
end
