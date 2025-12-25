# frozen_string_literal: true

FactoryBot.define do
  factory :lexeme do
    language
    sequence(:body) { |i| "Lexeme#{i}" }
  end
end
