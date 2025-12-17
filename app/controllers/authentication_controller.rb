# frozen_string_literal: true

class AuthenticationController < ApplicationController
  before_action :require_authentication, except: %i[authenticate login]

  # get /me
  def me
    @user = current_user
  end

  # post /login
  def authenticate
    slug = params[:login].to_s
    password = params[:password].to_s
    result = Components::UsersComponent.authenticate(slug, password)

    render_authentication_result(result)
  end

  # get /login
  def login
  end

  private

  # @param [User|FalseClass] result
  def render_authentication_result(result)
    if result.is_a?(User)
      session[:user_id] = result.id
      redirect_to me_path
    else
      render :login, status: :unauthorized
    end
  end
end
