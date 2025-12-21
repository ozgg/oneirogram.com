# frozen_string_literal: true

module Components
  module Oneirogram
    # Handle dreams creation and update
    class DreamHandler < BaseComponent
      # @param [Array] parameters
      def create(parameters)
        attributes = only_permitted_parameters(parameters).merge(user_id:)
        dream = Dream.create(attributes)
        @errors = dream.errors
        dream
      end

      # @param [Dream] dream
      # @param [Hash] parameters
      def update(dream, parameters)
        attributes = only_permitted_parameters(parameters)
        result = dream.update(attributes)
        @errors = dream.errors
        result
      end

      # @return [Array<Symbol>]
      def self.permitted_parameters
        %i[body lucidity privacy sleep_place_id title]
      end

      private

      def only_permitted_parameters(parameters)
        list = self.class.permitted_parameters.index_with do |parameter|
          parameters[parameter]
        end

        user.present? ? list : list.slice(:body, :title)
      end
    end
  end
end
