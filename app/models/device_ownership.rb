class DeviceOwnership < ApplicationRecord
  belongs_to :device
  belongs_to :user

  validates :assigned_at, presence: true
end
