# frozen_string_literal: true

# Link between dream and image
#
# Attributes:
#   created_at [DateTime]
#   dream_id [Dream]
#   dream_image_id [DreamImage]
#   updated_at
class DreamImageDream < ApplicationRecord
  belongs_to :dream_image, counter_cache: :dreams_count
  belongs_to :dream

  validates :dream_image_id,
            uniqueness: { scope: :dream_id }
  validate :ownership_consistency

  private

  def ownership_consistency
    return if dream&.user_id == dream_image&.user_id

    errors.add(:dream_image, :invalid)
  end
end
