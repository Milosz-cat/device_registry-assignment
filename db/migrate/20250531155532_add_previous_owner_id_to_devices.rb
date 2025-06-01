class AddPreviousOwnerIdToDevices < ActiveRecord::Migration[7.1]
  def change
    add_column :devices, :previous_owner_id, :integer
  end
end
