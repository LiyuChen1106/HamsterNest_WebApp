class CancelApprovalDefaultValue < ActiveRecord::Migration[5.2]
  def change
    change_column :borrow_requests, :approval, :boolean, :default => nil
  end
end
