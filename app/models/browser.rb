# frozen_string_literal: true

# Browser
#
# Attributes:
#   created_at [DateTime]
#   name [String] User Agent
#   updated_at [DateTime]
class Browser < ApplicationRecord
  normalizes :name, with: -> { it[0..511] }

  validates :name,
            presence: true,
            uniqueness: true

  # @param [String] name
  # @return [Browser|nil]
  def self.[](name)
    return if name.blank?

    find_or_create_by(name:)
  end
end
