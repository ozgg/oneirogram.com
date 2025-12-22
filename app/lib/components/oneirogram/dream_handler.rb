# frozen_string_literal: true

module Components
  module Oneirogram
    # Handle dreams creation and update
    class DreamHandler < BaseComponent
      # @param [Hash] parameters
      def create(parameters)
        attributes = only_permitted_parameters(parameters).merge(user_id:)
        entity = Dream.create(attributes)
        @errors = entity.errors
        entity
      end

      # @param [Dream] entity
      # @param [Hash] parameters
      def update(entity, parameters)
        attributes = only_permitted_parameters(parameters)
        result = entity.update(attributes)
        @errors = entity.errors
        result
      end

      # @return [Array<Symbol>]
      def self.permitted_parameters
        %i[body lucidity privacy sleep_place_id title]
      end

      private

      # @param [Hash] parameters
      def only_permitted_parameters(parameters)
        list = self.class.permitted_parameters.index_with do |parameter|
          parameters[parameter]
        end

        user.present? ? list : list.slice(:body, :title)
      end
    end
  end
end
