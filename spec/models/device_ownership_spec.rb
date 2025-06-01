require 'rails_helper'

RSpec.describe DeviceOwnership, type: :model do
  let(:user)   { create(:user) }
  let(:device) { create(:device, owner: user) }

  it 'is valid with valid attributes' do
    ownership = DeviceOwnership.new(device: device, user: user, assigned_at: Time.current)
    expect(ownership).to be_valid
  end

  it 'is invalid without assigned_at' do
    ownership = DeviceOwnership.new(device: device, user: user, assigned_at: nil)
    expect(ownership).not_to be_valid
  end
end
