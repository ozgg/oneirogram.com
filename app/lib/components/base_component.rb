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

    # @param [ApplicationRecord] entity
    def self.text_for_link(entity)
      entity.respond_to?(:text_for_link) ? entity.text_for_link : entity.id
    end

    # @param [ApplicationRecord] entity
    # @param [Symbol|String] scope
    def self.entity_link(entity, scope = '')
      prefix = %i[admin my].include?(scope.to_sym) ? scope : 'world'
      message = :"#{prefix}_url"
      if entity.respond_to?(message)
        entity.send(message)
      else
        rest_entity_link(entity, scope.to_sym)
      end
    end

    # @param [ApplicationRecord] entity
    # @param [Symbol] scope
    def self.rest_entity_link(entity, scope)
      collection = "/#{scope}/#{entity.class.table_name}".gsub('//', '/')
      if entity.attributes.key?('uuid') && scope != :admin
        "#{collection}/#{entity.uuid}"
      else
        "#{collection}/#{entity.id}"
      end
    end
  end
end
