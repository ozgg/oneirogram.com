# frozen_string_literal: true

module Components
  # Base component
  class BaseComponent
    attr_reader :errors, :user

    def initialize(user: nil)
      @errors = {}
      @user = user
    end

    def user_id
      user&.id
    end
  end
end
