class ChangePhoneParameter < ActiveRecord::Migration[5.2]
  def change
    change_column :clients, :home_phone, :string, limit: 20
    change_column :clients, :cell_phone, :string, limit: 20
    change_column :users, :phone_number, :string, limit: 20
  end
end
