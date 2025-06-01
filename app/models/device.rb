class Device < ApplicationRecord
  belongs_to :owner, class_name: 'User', optional: true

  has_many :device_ownerships, dependent: :destroy
  has_many :historical_owners, through: :device_ownerships, source: :user

  validates :serial_number, presence: true, uniqueness: true

  def has_been_owned_by?(user)
    device_ownerships.where(user: user).exists?
  end
end
