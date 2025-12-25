# frozen_string_literal: true

FactoryBot.define do
  factory :word do
    sequence(:body) { |i| "word#{i}" }
  end
end
