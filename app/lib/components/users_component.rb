# frozen_string_literal: true

module Components
  # Users component
  class UsersComponent
    # Authenticate with login and password
    #
    # @param [String] login
    # @param [String] password
    # @return [User,FalseClass]
    def self.authenticate(login, password)
      user = User.find_by('lower(slug) = ?', login.to_s.downcase)
      return false if user.nil?

      user.authenticate(password)
    end
  end
end
