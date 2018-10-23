class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :shift_dates, :invoice_id, :invoice_date_id
  end
end
