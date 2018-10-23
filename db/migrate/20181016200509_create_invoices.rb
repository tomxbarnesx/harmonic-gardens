class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.integer :client_id
      t.date :start_date
      t.integer :total_cost, precision: 10, scale: 2
      t.string :master_desc

      t.timestamps
    end
  end
end
