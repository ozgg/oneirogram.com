# frozen_string_literal: true

# Word form
#
# Attributes:
#   defective [Boolean]
#   lexeme_id [Lexeme]
#   word_id [Word]
class WordForm < ApplicationRecord
  belongs_to :lexeme
  belongs_to :word

  validates :word_id, uniqueness: { scope: :lexeme_id }
end
