class AddProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :user_profiles, index: true
  end
end
