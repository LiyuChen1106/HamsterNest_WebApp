class ChangeReturnStatus < ActiveRecord::Migration[5.2]
  def change
    remove_column :borrow_requests, :return_status, :boolean
    #0 idle, 1 return, 2 received
    add_column :borrow_requests, :return_status, :integer, :default => 0
  end
end
