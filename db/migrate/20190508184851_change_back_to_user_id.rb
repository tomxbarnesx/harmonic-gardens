class ChangeBackToUserId < ActiveRecord::Migration[5.2]
  def change
    rename_column :shifts, :logging_id, :user_id
  end
end
