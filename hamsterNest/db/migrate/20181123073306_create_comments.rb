class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :item, null:false, foreign_key: true
      t.references :user_profile, null:false, foreign_key: true
      t.date :comment_date, null:false
      t.string :comment_message
      t.timestamps
  
    end
  end
end
