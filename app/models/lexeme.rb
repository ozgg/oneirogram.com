# frozen_string_literal: true

# Lexeme
#
# Attributes:
#   body [String]
#   created_at [DateTime]
#   dreams_count [Integer]
#   language_id [Language]
#   updated_at [DateTime]
#   weight [Integer]
class Lexeme < ApplicationRecord
  belongs_to :language

  validates :body,
            presence: true,
            length: { maximum: 50 },
            uniqueness: { scope: :language_id }
end
