class AddRatingpeopleToUserProfile < ActiveRecord::Migration[5.2]
  def change
     #how many people rating for lending rate
     t.integer :lpeople, default:0
     #how many people rating for borrowing rate
     t.integer :bpeople, default:0
  end
end
