# frozen_string_literal: true

require 'rails_helper' # not 'rspec', becuase in Rails spec files, it is recommended to require 'rails_helper', not 'spec_helper' or 'rspec'. The 'rails_helper' file includes the 'spec_helper' file and also sets up the Rails environment, which is necessary for running tests that interact with the Rails framework

RSpec.describe ReturnDeviceFromUser do
  subject(:return_device) do
    described_class.new(
      requesting_user: requesting_user,
      serial_number: serial_number,
      from_user: from_user_id
    ).call
  end

  let(:requesting_user) { create(:user) }
  let(:serial_number) { '987654' }

  context 'when user returns a device they currently own' do
    let(:from_user_id) { requesting_user.id }

    before do
      device = create(:device, serial_number: serial_number, owner: requesting_user)
      create(:device_ownership, device: device, user: requesting_user, assigned_at: 1.day.ago)
    end

    it 'clears the owner_id and sets returned_at on ownership' do
      return_device

      device = Device.find_by(serial_number: serial_number)
      expect(device.owner_id).to be_nil

      ownership = device.device_ownerships.order(assigned_at: :desc).first
      expect(ownership.returned_at).not_to be_nil
    end
  end

  context 'when user tries to return a device owned by someone else' do
    let(:owner_user) { create(:user) }
    let(:from_user_id) { owner_user.id }
  
    before do
      device = create(:device, serial_number: serial_number, owner: owner_user)
      create(:device_ownership, device: device, user: owner_user, assigned_at: 2.days.ago)
    end
  
    it 'does not allow it and does not change ownership' do
      expect {
        return_device
      }.not_to change {
        Device.find_by(serial_number: serial_number).owner_id
      }
    end
  end

  context 'when user returns a device and then tries to re-assign it again' do
    let(:from_user_id) { requesting_user.id }
  
    before do
      AssignDeviceToUser.new(
        requesting_user: requesting_user,
        serial_number: serial_number,
        new_device_owner_id: requesting_user.id
      ).call
  
      return_device
    end
  
    it 'does not allow to assign it again' do
      expect {
        AssignDeviceToUser.new(
          requesting_user: requesting_user,
          serial_number: serial_number,
          new_device_owner_id: requesting_user.id
        ).call
      }.to raise_error(AssigningError::AlreadyUsedOnUser)
    end
  end
end
