class CreateBorrowRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :borrow_requests do |t|
      t.references :item, null:false, foreign_key: true
      t.references :user_profile, null:false, foreign_key: true
      t.boolean :approval, default:false
      t.date :borrow_date, null:false
      t.date :return_date, null:false
      t.string :request_message

      t.timestamps
    end
  end
end
