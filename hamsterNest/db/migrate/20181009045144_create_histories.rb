class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.integer :itemid
      t.integer :borrowers
      t.date :lend_dates
      t.date :return_dates

      t.timestamps
    end
  end
end
