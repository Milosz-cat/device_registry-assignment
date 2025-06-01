# frozen_string_literal: true

class AssignDeviceToUser
  def initialize(requesting_user:, serial_number:, new_device_owner_id:)
    @requesting_user = requesting_user
    @serial_number = serial_number
    @new_device_owner_id = new_device_owner_id
  end

  def call

    # 0. It is not allowed to assign the device to another user
    if @requesting_user.id != @new_device_owner_id
      raise RegistrationError::Unauthorized
    end

    device = Device.find_by(serial_number: @serial_number)
    # 1. If the device does not exist, create a new one
    if device.nil?
      return Device.create!(serial_number: @serial_number, owner_id: @new_device_owner_id)
    end

    
    # 2. If the device is still assigned – do not allow
    if device.owner_id.present?
      raise AssigningError::AlreadyUsedOnOtherUser
    end

    # 3. If the device was previously assigned to the same user and returned - do not allow
    # This test was failing for a long time because the device was being created
    # each time instead of preserving state between calls.The issue was fixed by analyzing logs and:
    # - ensuring ReturnDeviceFromUser sets previous_owner_id correctly,
    # - fresh AssignDeviceToUser instance is used for the second call in tests.
    # - adding validates :serial_number, presence: true, uniqueness: true in model definition.
    if device.owner_id.nil? && device.previous_owner_id == @requesting_user.id
      raise AssigningError::AlreadyUsedOnUser
    end

    # Everything OK - assign the device to the user
    device.update!(owner_id: @new_device_owner_id)
  end
end
