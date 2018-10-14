class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.references :item, foreign_key: true
      t.references :borrower, references: :user_details
      t.date :lend_date
      t.date :return_date

      t.timestamps
    end
  end
end
