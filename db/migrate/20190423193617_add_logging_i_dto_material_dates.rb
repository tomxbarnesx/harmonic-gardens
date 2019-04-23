class AddLoggingIDtoMaterialDates < ActiveRecord::Migration[5.2]
  def change
    add_column :material_dates, :logging_id, :integer
  end
end
