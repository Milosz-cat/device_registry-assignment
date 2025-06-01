class User < ApplicationRecord
  has_many :api_keys, as: :bearer
  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :devices, class_name: 'Device', foreign_key: :owner_id, dependent: :nullify
  has_many :previously_owned_devices, class_name: 'Device', foreign_key: :previous_owner_id, dependent: :nullify
end
