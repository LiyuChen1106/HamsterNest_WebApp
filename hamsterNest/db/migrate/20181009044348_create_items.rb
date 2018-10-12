class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :itemid
      t.integer :category_id
      t.string :item_name
      t.integer :amount
      t.integer :owner
      t.boolean :status
      t.date :loan_date
      t.date :expected_return_date
      t.date :actual_return_date

      t.timestamps
    end
  end
end
