# frozen_string_literal: true

FactoryBot.define do
  factory :dream_image do
    user
    sequence(:name) { |i| "Image #{i}" }
  end
end
