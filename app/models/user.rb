# frozen_string_literal: true

# User
#
# Attributes:
#   active [Boolean] User is active
#   bot [Boolean] User is bot
#   created_at [DateTime]
#   deleted_at [DateTime]
#   email [String] Primary email
#   email_confirmed [Boolean]
#   inviter_id [User] Who invited this user
#   notice [String] Administrative notice
#   password_digest [String]
#   profile [JSON]
#   referral_code [String]
#   settings [JSON]
#   slug [String]
#   super_user [Boolean] User has super privileges
#   updated_at [DateTime]
#   uuid [UUID]
class User < ApplicationRecord
  include HasUuid

  has_secure_password

  attribute :referral_code, default: -> { SecureRandom.alphanumeric(16) }

  belongs_to :inviter, class_name: 'User', optional: true
  has_many :invitees,
           class_name: 'User',
           foreign_key: :inviter_id,
           dependent: :nullify,
           inverse_of: :inviter
  has_many :sleep_places, dependent: :delete_all
  has_many :dreams, dependent: :delete_all
  has_many :dream_images, dependent: :delete_all

  normalizes :email, with: -> { it.strip.presence }

  validates :active, inclusion: { in: [true, false] }
  validates :bot, inclusion: { in: [true, false] }
  validates :email,
            uniqueness: { case_sensitive: false },
            allow_nil: true,
            format: URI::MailTo::EMAIL_REGEXP,
            length: { maximum: 200 }
  validates :email_confirmed, inclusion: { in: [true, false] }
  validates :profile, hash_field: true
  validates :referral_code,
            uniqueness: true,
            length: { minimum: 1, maximum: 16 },
            allow_nil: true
  validates :slug,
            uniqueness: { case_sensitive: false },
            format: /\A[_a-z0-9]+\z/i,
            length: { minimum: 1, maximum: 24 }
  validates :super_user, inclusion: { in: [true, false] }
end
