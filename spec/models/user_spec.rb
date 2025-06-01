require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = User.new(email: 'user@example.com', password: 'password', password_confirmation: 'password')
    expect(user).to be_valid
  end

  it 'is invalid without email' do
    user = User.new(email: nil, password: 'password', password_confirmation: 'password')
    expect(user).not_to be_valid
  end
end