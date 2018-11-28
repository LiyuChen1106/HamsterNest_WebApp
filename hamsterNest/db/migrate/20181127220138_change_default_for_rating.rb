class ChangeDefaultForRating < ActiveRecord::Migration[5.2]
  def change
    change_column :user_profiles, :lend_rating, :integer, :default => 0
    change_column :user_profiles, :borrow_rating, :integer, :default => 0
  end
end
