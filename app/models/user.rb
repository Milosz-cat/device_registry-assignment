class User < ApplicationRecord
  has_many :api_keys, as: :bearer
  has_secure_password

  validates :email, presence: true, uniqueness: true

  has_many :devices, class_name: 'Device', foreign_key: :owner_id, dependent: :nullify

  has_many :device_ownerships, dependent: :destroy
  has_many :historically_owned_devices, through: :device_ownerships, source: :device
end