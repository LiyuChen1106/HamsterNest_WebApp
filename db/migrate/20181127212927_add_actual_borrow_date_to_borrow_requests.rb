class AddActualBorrowDateToBorrowRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :borrow_requests, :actual_borrow_date, :date
  end
end
