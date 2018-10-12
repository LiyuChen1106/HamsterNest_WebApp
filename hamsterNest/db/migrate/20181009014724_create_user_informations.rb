class CreateUserInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :user_informations do |t|
      t.integer :userid
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :email
      t.integer :lend_rate
      t.integer :borrow_rate
      t.string :item_lists
      t.string :available_items
      t.string :friends

      t.timestamps
    end
  end
end
