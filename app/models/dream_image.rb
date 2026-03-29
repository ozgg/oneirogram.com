# frozen_string_literal: true

# Personal dream image
#
# Attributes:
#   created_at [DateTime]
#   description [Text]
#   dreams_count [Integer]
#   generic_image_id [GenericImage]
#   name [String]
#   privacy [integer] (enum)
#   updated_at [DateTime]
#   user_id [User]
#   uuid [UUID]
class DreamImage < ApplicationRecord
  include HasUuid
  include HasPrivacy

  belongs_to :user
  belongs_to :generic_image, optional: true
  has_many :dream_image_dreams, dependent: :destroy
  has_many :dreams, through: :dream_image_dreams

  validates :name,
            presence: true,
            uniqueness: { scope: :user_id },
            length: { maximum: 50 }
end
