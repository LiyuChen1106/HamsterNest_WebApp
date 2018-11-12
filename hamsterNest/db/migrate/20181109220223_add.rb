class Add < ActiveRecord::Migration[5.2]
  def change
    add_column :borrow_requests, :read_status, :boolean, :default => false
  end
end
