class AddCostColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :material_dates, :cost, :decimal, precision: 10, scale: 2
    rename_column :materials, :type, :name
  end
end
