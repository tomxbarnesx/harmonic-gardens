class AddEmployeeNumberToShifts < ActiveRecord::Migration[5.2]
  def change
    remove_column :shifts, :user_id
    add_column :shifts, :employee_count, :integer
    remove_column :material_dates, :override
    rename_column :material_dates, :invoice_date_id, :client_id
    add_column :material_dates, :charge, :decimal, precision: 10, scale: 2
    add_column :material_dates, :date, :date
  end
end
