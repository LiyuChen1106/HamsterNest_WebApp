class DeleteUseridAndItemId < ActiveRecord::Migration[5.2]
  def change
=begin
    remove_column :user_accounts, :userid, :integer
    remove_column :user_details, :userid, :integer
    remove_column :items, :itemid, :integer
    remove_column :categories, :category_id, :integer 
=end  
  end
end
