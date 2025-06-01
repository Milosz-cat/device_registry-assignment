class Device < ApplicationRecord
  belongs_to :owner, class_name: 'User', optional: true
  belongs_to :previous_owner, class_name: 'User', optional: true

  validates :serial_number, presence: true, uniqueness: true
end
