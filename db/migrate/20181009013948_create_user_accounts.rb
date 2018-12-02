class CreateUserAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :user_accounts, id: false do |t|
      t.string :email, primary_key: true
      t.string :password
      t.string :salt
      t.references :username, references: :user_profiles

      t.timestamps
    end
  end

  create_table :categories do |t|
    t.string :category_name

    t.timestamps
  end

end
