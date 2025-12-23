# frozen_string_literal: true

FactoryBot.define do
  factory :dream_image_dream do
    transient do
      user { association(:user) }
    end

    dream_image { association(:dream_image, user:) }
    dream { association(:dream, user:) }
  end
end
