class CreateMaterialDates < ActiveRecord::Migration[5.2]
  def change
    create_table :material_dates do |t|
      t.integer :material_id
      t.integer :invoice_date_id
      t.integer :quantity

      t.timestamps
    end
  end
end
