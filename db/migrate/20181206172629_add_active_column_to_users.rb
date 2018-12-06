class AddActiveColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_active, :boolean, default: true
    add_column :users, :phone_number, :string, limit: 10
    change_column :clients, :home_phone, :string, limit: 10
    change_column :clients, :cell_phone, :string, limit: 10
  end
end
