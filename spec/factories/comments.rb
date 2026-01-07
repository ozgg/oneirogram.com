# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    commentable_uuid { SecureRandom.uuid }
    commentable_type { 'Dream' }
    user
    body { 'Some random comment' }
  end
end
