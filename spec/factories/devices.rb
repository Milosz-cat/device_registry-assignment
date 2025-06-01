FactoryBot.define do
  factory :device do
    sequence(:serial_number) { |n| "#{n}#{n}#{n}#{n}#{n}#{n}" }

    owner { nil }

  end
end