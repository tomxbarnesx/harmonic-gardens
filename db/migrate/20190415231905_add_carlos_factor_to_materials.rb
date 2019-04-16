class AddCarlosFactorToMaterials < ActiveRecord::Migration[5.2]
  def change
    add_column :materials, :foreman_priority, :boolean
    change_column :material_dates, :quantity, :decimal, precision: 10, scale: 2
  end
end
