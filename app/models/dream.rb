# frozen_string_literal: true

# Dream
#
# Attributes:
#   body [text]
#   created_at [DateTime]
#   language_id [Language]
#   lucidity [integer]
#   privacy [integer] (enum)
#   sleep_place_id [SleepPlace]
#   title [string]
#   uuid [uuid]
#   user_id [User]
#   updated_at [DateTime]
class Dream < ApplicationRecord
  include HasUuid

  belongs_to :user, optional: true
  belongs_to :sleep_place, optional: true
  belongs_to :language, optional: true

  enum :privacy, { generally_accessible: 0, for_community: 1, personal: 2 }

  validates :body, presence: true, length: { minimum: 20, maximum: 50_000 }
  validates :lucidity, presence: true, numericality: { in: (0..5) }
  validates :privacy, presence: true
  validates :title, length: { maximum: 200 }
  validate :sleep_place_should_match_owner

  normalizes :privacy,
             with: -> { it.privacy = :generally_accessible if it.user_id.nil? }

  scope :recent, -> { order(created_at: :desc) }
  scope :list_for_user, ->(user) { where(privacy: Dream.privacy_for_user(user)).or(owned_by(user)) }
  scope :owned_by, ->(user) { where(user:) }

  # @param [User|nil] user
  # @param [Integer] page
  def self.page_for_user(user, page = 1)
    list_for_user(user).page(page)
  end

  # Privacy list for user context
  #
  # @param [User|nil] user
  # @return [Array]
  def self.privacy_for_user(user)
    if user.nil?
      [privacies[:generally_accessible]]
    else
      [privacies[:generally_accessible], privacies[:for_community]]
    end
  end

  # @param [User|nil] user
  # @return [TrueClass,FalseClass]
  def visible_to?(user)
    return true if generally_accessible? || owned_by?(user)

    user.present? && for_community?
  end

  # @param [User|nil] user
  # @return [TrueClass,FalseClass]
  def owned_by?(user)
    return false if user.nil?

    user_id == user.id
  end

  private

  def sleep_place_should_match_owner
    return if sleep_place.nil?
    return if sleep_place.user_id == user_id

    errors.add(:sleep_place, :invalid)
  end
end
