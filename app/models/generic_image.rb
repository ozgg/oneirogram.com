# frozen_string_literal: true

# Generic dream image
#
# Attributes:
#   created_at [DateTime]
#   description [Text]
#   dreams_count [Integer]
#   language_id [Language]
#   name [String]
#   summary [String]
#   updated_at [DateTime]
#   uuid [UUID]
#   weight [Integer]
class GenericImage < ApplicationRecord
  include HasUuid

  belongs_to :language
  has_many :dream_generic_images, dependent: :destroy
  has_many :dreams, through: :dream_generic_images

  validates :name,
            presence: true,
            uniqueness: { scope: %i[language_id], case_sensitive: false },
            length: { maximum: 50 }
  validates :summary, length: { maximum: 200 }
end
