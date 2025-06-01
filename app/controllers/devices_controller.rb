class DevicesController < ApplicationController
  before_action :authenticate_user!, only: %i[assign unassign assigned]

  def assign
    AssignDeviceToUser.new(
      requesting_user: current_user,
      serial_number: params.dig(:device, :serial_number), # After debbugin it turn out we need to fetch nested parameter (avoid nil in case of no key)
      new_device_owner_id: params[:new_owner_id].to_i # to_i - prevents String vs Integer comparisons
    ).call

    head :ok
  rescue RegistrationError::Unauthorized
    render json: { error: 'Unauthorized' }, status: :unprocessable_entity
  end

  def unassign
    ReturnDeviceFromUser.new(
      requesting_user: current_user,
      serial_number: params.dig(:device, :serial_number),
      from_user: current_user.id
    ).call

    head :ok
  rescue StandardError
    render json: { error: 'Could not unassign device' }, status: :unprocessable_entity
  end

  def assigned
    devices = Device.where(owner_id: current_user.id)
    render json: devices.as_json(only: [:id, :serial_number])
  end

  def device_history
    device = Device.find_by(serial_number: params[:serial_number])
    return render json: { error: 'Device not found' }, status: :not_found unless device
  
    history = device.device_ownerships.order(assigned_at: :asc).map do |ownership|
      {
        user_id: ownership.user_id,
        assigned_at: ownership.assigned_at,
        returned_at: ownership.returned_at
      }
    end
  
    render json: history
  end

  private

  def device_params
    params.permit(:new_owner_id, :serial_number)
  end
end
