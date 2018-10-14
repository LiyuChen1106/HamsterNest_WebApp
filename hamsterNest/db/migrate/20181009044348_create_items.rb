class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :category, foreign_key: true
      t.string :item_name
      t.references :owner, references: :user_details
      t.boolean :status
      t.date :loan_data
      t.date :expected_return_date
      t.date :actual_return_date

      t.timestamps
    end

    # add_reference :items, :author, index: true
    # add_foreign_key :items, :users, column: :author_id
  end
end
