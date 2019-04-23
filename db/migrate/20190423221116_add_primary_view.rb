class AddPrimaryView < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :address_view, :boolean, default: true
  end
end
