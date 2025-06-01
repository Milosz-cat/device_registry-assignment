module ReturnError
  class DeviceNotFound < StandardError; end
  class OwnershipNotFound < StandardError; end
end