# frozen_string_literal: true

# It was implemented to make AssignDeviceToUser tests pass correctly.
# Assigning should be blocked if a user already had the device in the past,
# so we must mark the previous ownership as "returned".
class ReturnDeviceFromUser
  def initialize(requesting_user:, serial_number:, from_user:)
    @requesting_user = requesting_user
    @serial_number = serial_number
    @from_user = from_user
  end

  def call
    device = Device.find_by(serial_number: @serial_number)

    raise ReturnError::DeviceNotFound unless device

    return unless device.owner_id == @requesting_user.id

    # Remove current ownership
    device.update!(owner_id: nil)

     # Find the last active ownership record for this user (not yet returned)
    ownership = device.device_ownerships
                     .where(user_id: @from_user, returned_at: nil)
                     .order(assigned_at: :desc)
                     .first

    raise ReturnError::OwnershipNotFound unless ownership                 

    # Mark it as returned if found
    ownership.update!(returned_at: Time.current)
  end
end
