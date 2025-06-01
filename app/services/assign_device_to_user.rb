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
    
    # 1. Check if the user has reached the limit of device assignments
    if @requesting_user.device_assignment_limit &&
      @requesting_user.device_assignment_limit <= Device.where(owner_id: @requesting_user.id).count
     raise AssigningError::AssignmentLimitReached
    end

    device = Device.find_by(serial_number: @serial_number)

    # 2. If the device does not exist, create a new one and ownership history
    if device.nil?
      device = Device.create!(serial_number: @serial_number, owner_id: @new_device_owner_id)
      device.device_ownerships.create!(
        user_id: @new_device_owner_id,
        assigned_at: Time.current
      )
      return device
    end

    # 3. If the device is still assigned – do not allow
    if device.owner_id.present?
      raise AssigningError::AlreadyUsedOnOtherUser
    end

    # 4. If user previously owned the device (from ownership history)
    # In the previous version of the logic, `previous_owner_id` field was used, which stored only the last owner of the device. This approach was very limited:
    # - it did not store the full history of owners,
    # - it was not possible to check if the user had owned the device more than once,
    # - the test logic was fragile - it was difficult to reproduce and confirm assignment/return cases.
    #
    # For this reason, `device_ownerships` table was creted, which records:
    # - each time the device was assigned to the user (the `assigned_at` field),
    # - the time of return (the `returned_at` field),
    # - the ability to check if the user ever owned the device.
    if device.device_ownerships.exists?(user_id: @new_device_owner_id)
      raise AssigningError::AlreadyUsedOnUser
    end

    # Everything OK - assign the device to the user and add to history
    device.update!(owner_id: @new_device_owner_id)
    device.device_ownerships.create!(
      user_id: @new_device_owner_id,
      assigned_at: Time.current
    )
  end
end
