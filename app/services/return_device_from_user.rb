# frozen_string_literal: true

class ReturnDeviceFromUser
  def initialize(user:, serial_number:, from_user:)
    @user = user
    @serial_number = serial_number
    @from_user = from_user
  end

  def call
    device = Device.find_by(serial_number: @serial_number)
    return if device.nil? || device.owner_id != @from_user # If it doesn't exist or doesn't belong to the from_user

    device.owner_id = nil
    device.previous_owner_id = @from_user
    device.save!
    device.reload # Reload to ensure the changes are reflected in the object
  end
end
