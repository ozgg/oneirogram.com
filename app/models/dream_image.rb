# frozen_string_literal: true

# Personal dream image
#
# Attributes:
#   created_at [DateTime]
#   dreams_count [Integer]
#   name [String]
#   updated_at [DateTime]
#   user_id [User]
#   uuid [UUID]
class DreamImage < ApplicationRecord
  include HasUuid

  belongs_to :user
  has_many :dream_image_dreams, dependent: :destroy
  has_many :dreams, through: :dream_image_dreams

  validates :name,
            presence: true,
            uniqueness: { scope: :user_id },
            length: { maximum: 50 }
end
