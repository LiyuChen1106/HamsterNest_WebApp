class CreateUserDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :user_details, id: false do |t|
      t.string :username, primary_key: true
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.integer :lend_rating
      t.integer :borrow_rating
      t.references :items_list, index: true, foreign_key: { to_table: :items }
      t.references :friends_list, index: true, foreign_key: { to_table: :user_details }

      t.timestamps
    end
  end
end
