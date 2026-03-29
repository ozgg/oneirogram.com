# frozen_string_literal: true

# Adds privacy field and constraints to model
module HasPrivacy
  extend ActiveSupport::Concern

  included do
    enum :privacy, { generally_accessible: 0, for_community: 1, personal: 2 }
    validates :privacy, presence: true
  end

  class_methods do
    # Privacy list for user context
    #
    # @param [User|nil] user
    # @return [Array]
    def privacy_for_user(user)
      if user.nil?
        [privacies[:generally_accessible]]
      else
        [privacies[:generally_accessible], privacies[:for_community]]
      end
    end
  end
end
