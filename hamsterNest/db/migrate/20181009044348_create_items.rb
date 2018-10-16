class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :category, foreign_key: true
      t.string :item_name
      t.references :owner, references: :user_profiles
      t.boolean :status

      t.timestamps
    end
  end
end
