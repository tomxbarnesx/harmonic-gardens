class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.string :type
      t.decimal :cost, precision: 10, scale: 2

      t.timestamps
    end
  end
end
