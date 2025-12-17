# frozen_string_literal: true

# Language
#
# Attributes:
#   code [String] locale code in IETF BCP 47 / RFC 4656 format
class Language < ApplicationRecord
  validates :code,
            presence: true,
            length: { in: (2..35) },
            uniqueness: true
end
