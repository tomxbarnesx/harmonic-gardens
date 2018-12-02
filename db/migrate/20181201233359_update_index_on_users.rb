class UpdateIndexOnUsers < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, :email
    change_column_default :users, :email, from: nil, to: 'harmonicgardendesign@gmail.com'
  end
end
