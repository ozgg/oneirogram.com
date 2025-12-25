# frozen_string_literal: true

# Word
#
# Attributes:
#   body [String]
#   created_at [DateTime]
#   updated_at [DateTime]
#   weight [Integer]
class Word < ApplicationRecord
  normalizes :body, with: -> { it.strip.downcase[0..49] }

  validates :body,
            presence: true,
            uniqueness: { case_sensitive: false }
end
