# frozen_string_literal: true

# Browser
#
# Attributes:
#   created_at [DateTime]
#   name [String] User Agent
#   updated_at [DateTime]
class Browser < ApplicationRecord
  normalizes :name, with: ->(name) { name[0..511] }

  validates :name,
            presence: true,
            uniqueness: true
end
