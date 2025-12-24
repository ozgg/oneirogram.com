# frozen_string_literal: true

FactoryBot.define do
  factory :generic_image do
    language
    sequence(:name) { |i| "Generic dream image #{i}" }
  end
end
