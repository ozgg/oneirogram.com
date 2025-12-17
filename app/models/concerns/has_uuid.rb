# frozen_string_literal: true

# Adds UUID field and constraints to model
module HasUuid
  extend ActiveSupport::Concern

  included do
    attribute :uuid, default: -> { SecureRandom.uuid }
    validates :uuid, presence: true, uniqueness: { case_sensitive: false }
  end
end
