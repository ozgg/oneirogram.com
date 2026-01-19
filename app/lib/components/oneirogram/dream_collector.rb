# frozen_string_literal: true

module Components
  module Oneirogram
    # Collecting dreams for lists
    class DreamCollector
      attr_accessor :user
      attr_reader :collection, :list

      delegate :any?, to: :list
      delegate :each, to: :collection

      # @param [User|nil] user
      def initialize(user)
        @user = user
      end

      # @param [Integer] page
      def public_page(page = 1)
        @list = Dream.page_for_user(user, page)
        @collection = @list.map { |dream| DreamContainer.new(user, dream) }
      end
    end
  end
end
