# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:slug) { |n| "user#{n}" }
    password_digest { BCrypt::Password.create('secret') }
  end
end
