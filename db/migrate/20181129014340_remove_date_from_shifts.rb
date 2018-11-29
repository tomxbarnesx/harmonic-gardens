class RemoveDateFromShifts < ActiveRecord::Migration[5.2]
  def change
    remove_column :shifts, :date, :date
    add_column :shift_dates, :earned, :decimal, precision: 10, scale: 2
    add_column :material_dates, :override, :boolean, default: false
  end
end
