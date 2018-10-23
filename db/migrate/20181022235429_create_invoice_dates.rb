class CreateInvoiceDates < ActiveRecord::Migration[5.2]
  def change
    create_table :invoice_dates do |t|
      t.integer :invoice_id
      t.date :date
      t.string :description
      t.decimal :subtotal, precision: 10, scale: 2, default: 0
      t.timestamps
    end
  end
end
