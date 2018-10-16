class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles, id: false do |t|
      t.string :email, null: false, default: ""
      t.string :username, null: false
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.integer :lend_rating
      t.integer :borrow_rating
      t.references :items_list, index: true, foreign_key: { to_table: :items }
      #t.references :friends_list, index: true, foreign_key: { to_table: :user_profiles }

      t.timestamps
    end
    
    add_index :user_profiles, :email, unique: true
    add_index :user_profiles, :username, unique: true
  end
end
