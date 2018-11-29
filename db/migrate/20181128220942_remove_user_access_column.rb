class RemoveUserAccessColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :user_access
    
  end
end
