FactoryBot.define do
  factory :device_ownership do
    device
    user
    assigned_at { Time.current }
    returned_at { nil }
  end
end