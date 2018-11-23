class AddRatingpeopleToUserProfile < ActiveRecord::Migration[5.2]
  def change
     #how many people rating for lending rate
     add_column :user_profiles, :lpeople, :integer, :default => 0
     #how many people rating for borrowing rate
     add_column :user_profiles, :bpeople, :integer, :default => 0
  end
end
