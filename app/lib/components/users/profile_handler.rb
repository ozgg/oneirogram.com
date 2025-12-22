# frozen_string_literal: true

module Components
  module Users
    # Handle creation and updates for user profiles
    class ProfileHandler < Components::BaseComponent
      def register(parameters)
        attributes = only_permitted_parameters(parameters)
        entity = User.create(attributes)
        @errors = entity.errors
        entity
      end

      def update(parameters)
        raise 'User is not set' if user.nil?

        attributes = only_permitted_parameters(parameters)
        result = user.update(attributes)
        @errors = user.errors
        result
      end

      def self.permitted_parameters
        %i[email password password_confirmation slug]
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
