class AddAvatarToUserProfiles < ActiveRecord::Migration[5.2]
  def up
    add_attachment :user_profiles, :avatar
  end

  def down
    remove_attachment :user_profiles, :avatar
  end
end
