class RemovePreviousOwnerFromDevices < ActiveRecord::Migration[7.1]
  def change
    remove_column :devices, :previous_owner_id, :integer
  end
end
