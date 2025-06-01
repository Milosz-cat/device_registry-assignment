require 'rails_helper'

RSpec.describe Device, type: :model do
  it 'is valid with valid attributes' do
    device = Device.new(serial_number: '123456')
    expect(device).to be_valid
  end

  it 'is invalid without a serial_number' do
    device = Device.new(serial_number: nil)
    expect(device).not_to be_valid
  end
end