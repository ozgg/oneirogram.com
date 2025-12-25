# frozen_string_literal: true

# Generic dream image in dream
#
# Attributes:
#   created_at [DateTime]
#   dream_id [Dream]
#   generic_image_id [GenericImage]
#   summary
#   updated_at [DateTime]
class DreamGenericImage < ApplicationRecord
  belongs_to :dream
  belongs_to :generic_image, counter_cache: :dreams_count

  validates :generic_image_id, uniqueness: { scope: :dream_id }
  validates :summary,
            presence: true,
            length: { maximum: 500 }
end
