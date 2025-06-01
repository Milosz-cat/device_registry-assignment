class AddDeviceAssignmentLimitToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :device_assignment_limit, :integer
  end
end
