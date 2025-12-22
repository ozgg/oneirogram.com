# frozen_string_literal: true

module Components
  module Oneirogram
    # Handle sleep place creation and update
    class SleepPlaceHandler < BaseComponent
      # @param [Array] parameters
      def create(parameters)
        attributes = only_permitted_parameters(parameters).merge(user_id:)
        SleepPlace.create(attributes)
      end

      # @param [SleepPlace] entity
      # @param [Hash] parameters
      def update(entity, parameters)
        attributes = only_permitted_parameters(parameters)
        entity.update(attributes)
      end

      # @return [Array<Symbol>]
      def self.permitted_parameters
        %i[name]
      end

      private

      def only_permitted_parameters(parameters)
        self.class.permitted_parameters.index_with do |parameter|
          parameters[parameter]
        end
      end
    end
  end
end
