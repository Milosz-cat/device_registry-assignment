class CreateDeviceOwnerships < ActiveRecord::Migration[7.1]
  def change
    create_table :device_ownerships do |t|
      t.references :device, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :assigned_at
      t.datetime :returned_at

      t.timestamps
    end
  end
end
