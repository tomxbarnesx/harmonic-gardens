class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :email
      t.integer :home_phone, limit: 8
      t.integer :cell_phone, limit: 8
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
