class AddUserColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :user_access, :string
    add_column :users, :username, :string
    add_column :users, :hourly_rate, :integer
  end
end
