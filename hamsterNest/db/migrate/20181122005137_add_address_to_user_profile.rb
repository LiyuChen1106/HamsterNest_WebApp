class AddAddressToUserProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :user_profiles, :address, :hstore
  end
end
