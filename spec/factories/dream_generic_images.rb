# frozen_string_literal: true

FactoryBot.define do
  factory :dream_generic_image do
    dream
    generic_image
    summary { 'Than means something for sure' }
  end
end
