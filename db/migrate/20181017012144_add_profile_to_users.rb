class AddProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :user_profile, index: true
  end
end
