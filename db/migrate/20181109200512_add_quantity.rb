class AddQuantity < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :quantity, :integer, :default => 1
    add_column :borrow_requests, :quantity, :integer, :default => 1
  end
end
