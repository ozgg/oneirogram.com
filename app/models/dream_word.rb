# frozen_string_literal: true

# Word used in dream
#
# Attributes:
#   dream_id [Dream]
#   weight [Integer]
#   word_id [Word]
class DreamWord < ApplicationRecord
  belongs_to :dream
  belongs_to :word

  validates :word_id, uniqueness: { scope: :dream_id }

  after_destroy :subtract_word_weight

  private

  def subtract_word_weight
    word.decrement_counter(:weight, weight)
  end
end
