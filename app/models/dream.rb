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
  has_many :dream_image_dreams, dependent: :destroy
  has_many :dream_images, through: :dream_image_dreams
  has_many :dream_generic_images, dependent: :destroy
  has_many :generic_images, through: :dream_generic_images
  has_many :dream_words, dependent: :destroy
  has_many :words, through: :dream_words

  enum :privacy, { generally_accessible: 0, for_community: 1, personal: 2 }

  validates :body, presence: true, length: { minimum: 20, maximum: 50_000 }
  validates :lucidity, presence: true, numericality: { in: (0..5) }
  validates :privacy, presence: true
  validates :title, length: { maximum: 200 }
  validate :sleep_place_should_match_owner

  before_validation :check_privacy, on: :create

  scope :recent, -> { order(id: :desc) }
  scope :list_for_user, ->(user) { where(privacy: Dream.privacy_for_user(user)).or(owned_by(user)).recent }
  scope :list_for_owner, ->(user) { owned_by(user).recent }
  scope :owned_by, ->(user) { where(user:) }

  # @param [User|nil] user
  # @param [Integer] page
  def self.page_for_user(user, page = 1)
    list_for_user(user).page(page).per(12)
  end

  # @param [User] user
  # @param [Integer] page
  def self.page_for_owner(user, page = 1)
    list_for_owner(user).page(page)
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

  def text_for_link
    title.presence || I18n.t(:untitled)
  end

  private

  def sleep_place_should_match_owner
    return if sleep_place.nil?
    return if sleep_place.user_id == user_id

    errors.add(:sleep_place, :invalid)
  end

  # Anonymous dreams are always generally accessible
  def check_privacy
    self.privacy = :generally_accessible if user_id.nil?
  end
end
