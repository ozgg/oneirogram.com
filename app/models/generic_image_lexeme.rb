# frozen_string_literal: true

# Lexeme for generic dream image
#
# Attributes:
#   created_at [DateTime]
#   generic_image_id [GenericImage]
#   lexeme_id [Lexeme]
#   updated_at [DateTime]
class GenericImageLexeme < ApplicationRecord
  belongs_to :generic_image
  belongs_to :lexeme

  validates :lexeme_id, uniqueness: { scope: :generic_image_id }
end
