class AddBorrowerReadStatusToBorrowRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :borrow_requests, :borrower_read_status, :boolean, :default => true
  end
end
