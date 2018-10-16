class DropUserAccounts < ActiveRecord::Migration[5.2]
  def up
    drop_table :user_accounts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
