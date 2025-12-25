# frozen_string_literal: true

# Sleep place where dreams are seen
#
# Attributes:
#   created_at [DateTime]
#   dreams_count [Integer]
#   name [String]
#   updated_at [DateTime]
#   user_id [User]
#   uuid [UUID]
class SleepPlace < ApplicationRecord
  include HasUuid

  belongs_to :user
  has_many :dreams, dependent: :nullify

  validates :name,
            presence: true,
            uniqueness: { scope: :user_id, case_sensitive: false },
            length: { maximum: 100 }

  scope :owned_by, ->(user) { where(user:) }
  scope :list_for_user, ->(user) { owned_by(user).order(dreams_count: :desc) }
end
