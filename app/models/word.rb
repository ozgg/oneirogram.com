# frozen_string_literal: true

# Word
#
# Attributes:
#   body [String]
#   created_at [DateTime]
#   updated_at [DateTime]
#   weight [Integer]
class Word < ApplicationRecord
  has_many :dream_words, dependent: :delete_all
  has_many :dreams, through: :dream_words

  normalizes :body, with: -> { it.strip.downcase[0..49] }

  validates :body,
            presence: true,
            uniqueness: { case_sensitive: false }
end
