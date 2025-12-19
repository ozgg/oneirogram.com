# frozen_string_literal: true

module Components
  module Oneirogram
    # Handle dreams creation and update
    class DreamHandler < BaseComponent
      # @param [Array] parameters
      def create(parameters)
        attributes = only_permitted_parameters(parameters)
        dream = Dream.create(attributes)
        @errors = dream.errors
        dream
      end

      # @param [Dream] dream
      # @param [Hash] parameters
      def update(dream, parameters)
        attributes = only_permitted_parameters(parameters)
        dream.update(attributes)
        @errors = dream.errors
        dream
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
