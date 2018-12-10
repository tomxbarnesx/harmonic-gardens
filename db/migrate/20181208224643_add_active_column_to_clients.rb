class AddActiveColumnToClients < ActiveRecord::Migration[5.2]
  def change
    rename_column :clients, :active, :is_active
    add_column :material_dates, :tax, :boolean, default: false
  end
end
