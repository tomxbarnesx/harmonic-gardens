class AddDescMaterialDates < ActiveRecord::Migration[5.2]
  def change
    add_column :material_dates, :description, :string 
  end
end
