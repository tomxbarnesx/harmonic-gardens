class CreateShiftDates < ActiveRecord::Migration[5.2]
  def change
    create_table :shift_dates do |t|
      t.integer :shift_id
      t.integer :invoice_id

      t.timestamps
    end
  end
end
