# frozen_string_literal: true

# Lexeme in dream
#
# Attributes:
#   created_at [DateTime]
#   dream_id [Dream]
#   lexeme_id [Lexeme]
#   updated_at [DateTime]
class DreamLexeme < ApplicationRecord
  belongs_to :dream
  belongs_to :lexeme

  validates :dream_id, uniqueness: { scope: :lexeme_id }
end
