class RenameMytable < ActiveRecord::Migration[5.2]
  def self.up
    rename_table :user_informations, :user_details
  end

  def self.down
    rename_table :user_details, :user_informations
  end
end
