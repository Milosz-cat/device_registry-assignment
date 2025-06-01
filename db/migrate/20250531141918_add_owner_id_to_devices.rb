class AddOwnerIdToDevices < ActiveRecord::Migration[7.1]
  def change
    add_column :devices, :owner_id, :integer
  end
end
