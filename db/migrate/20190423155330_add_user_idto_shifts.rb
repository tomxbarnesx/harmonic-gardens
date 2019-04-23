class AddUserIdtoShifts < ActiveRecord::Migration[5.2]
  def change
    add_column :shifts, :logging_id, :integer
    add_column :materials, :designer_priority, :boolean
  end
end
