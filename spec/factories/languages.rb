# frozen_string_literal: true

FactoryBot.define do
  factory :language do
    sequence(:code) { |i| "int-variant-#{i}" }
  end
end
