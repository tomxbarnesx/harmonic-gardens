class RemoveDateFromShifts < ActiveRecord::Migration[5.2]
  def change
    remove_column :shifts, :date
    add_column :shifts, :earned, :decimal, precision: 10, scale: 2
  end
end
