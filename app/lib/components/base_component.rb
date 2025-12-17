# frozen_string_literal: true

module Components
  # Base component
  class BaseComponent
    attr_reader :errors, :user

    def initialize(user: nil)
      @errors = {}
      @user = user
    end
  end
end
