class AddImageToItems < ActiveRecord::Migration[5.2]
  def up
    add_attachment :items, :image
  end
 
  def down
    remove_attachment :items, :image
  end
end
