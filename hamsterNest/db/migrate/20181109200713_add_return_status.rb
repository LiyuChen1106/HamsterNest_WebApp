class AddReturnStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :borrow_requests, :return_status, :boolean, :default => false
  end
end
