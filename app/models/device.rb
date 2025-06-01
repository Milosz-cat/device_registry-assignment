class Device < ApplicationRecord
  belongs_to :owner, class_name: 'User', optional: true
  belongs_to :previous_owner, class_name: 'User', optional: true
end
