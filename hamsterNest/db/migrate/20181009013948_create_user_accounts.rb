class CreateUserAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :user_accounts do |t|
      t.integer :userid
      t.string :email
      t.string :password
      t.string :salt

      t.timestamps
    end
  end
end
