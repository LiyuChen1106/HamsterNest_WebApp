class ChangeIdsName < ActiveRecord::Migration[5.2]
=begin
  def change
    change_table :histories do |t|
      t.rename :itemid, :item_id
    end

    change_table :categories do |t|
      t.rename :itemid, :item_id
    end

    change_table :user_details do |t|
      t.remove :email, :string
      t.rename :lend_rate, :lend_rating
      t.rename :borrow_rate, :borrow_rating
      t.rename :item_lists, :item_list
    end



  end
=end
end
