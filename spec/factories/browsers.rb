# frozen_string_literal: true

FactoryBot.define do
  factory :browser do
    sequence(:name) { |i| "Browser #{i}" }
  end
end
