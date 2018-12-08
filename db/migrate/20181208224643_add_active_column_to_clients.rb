class AddActiveColumnToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :is_active, :boolean, default: true
  end
end
