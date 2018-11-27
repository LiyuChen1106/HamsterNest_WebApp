class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.references :user, foreign_key: true, index: true
      t.string :username, null: false
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.integer :lend_rating, default:0
      t.integer :borrow_rating, default:0
      #t.references :items_list, index: true, foreign_key: {to_table: :items}
      #t.references :friends_list, index: true, foreign_key: { to_table: :user_profiles }

      t.timestamps
    end
  end
end
