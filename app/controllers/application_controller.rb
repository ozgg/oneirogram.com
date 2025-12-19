# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_page, :param_from_request, :current_user

  private

  # Get current page number from request
  #
  # @return [Integer]
  def current_page
    @current_page ||= (params[:page] || 1).to_s.to_i.abs
  end

  # Get parameter from request and normalize it
  #
  # Casts request parameter to UTF-8 string and removes invalid characters
  #
  # @param [Symbol] param
  # @return [String]
  def param_from_request(*param)
    value = params.dig(*param)
    value.to_s.encode('UTF-8', 'UTF-8', invalid: :replace, replace: '')
  end

  def encode_token(payload)
    JWT.encode(payload, jwt_key)
  end

  def jwt_token
    @jwt_token ||= decoded_token
  end

  def current_user
    @current_user ||= user_from_session
  end

  def require_authentication
    return unless current_user.nil?

    redirect_to login_path
  end

  def user_from_session
    user_id = session[:user_id]

    User.find_by(id: user_id) || user_from_token
  end

  def jwt_key
    @jwt_key ||= ENV.fetch('JWT_KEY')
  end

  def decoded_token
    header = request.headers['Authorization']
    return unless header

    token = header.split[1]
    begin
      JWT.decode(token, jwt_key)
    rescue JWT::DecodeError
      nil
    end
  end

  def user_from_token
    return unless jwt_token

    user_id = decoded_token[0]['user_id']
    User.find_by(uuid: user_id)
  end
end
