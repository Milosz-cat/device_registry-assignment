# frozen_string_literal: true

FactoryBot.define do # FactoryBot should take care of unique test data when generating data
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
