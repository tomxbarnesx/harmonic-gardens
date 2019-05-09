class ChangeLoggingtoUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :material_dates, :logging_id, :user_id
  end
end
