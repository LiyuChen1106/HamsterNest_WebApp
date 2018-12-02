class AddActualReturnDateToBorrowRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :borrow_requests, :actual_return_date, :date
  end
end
