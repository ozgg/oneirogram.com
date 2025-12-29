# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    commentable_uuid { SecureRandom.uuid }
    user
    body { 'Some random comment' }
  end
end
