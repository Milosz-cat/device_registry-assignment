class DevicesController < ApplicationController
  before_action :authenticate_user!, only: %i[assign unassign]

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
    # TODO: implement the unassign action
  end

  private

  def device_params
    params.permit(:new_owner_id, :serial_number)
  end
end
