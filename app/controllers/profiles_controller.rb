# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_entity, except: %i[new create]

  # get /join
  def new
    @entity = User.new
  end

  # get /me/edit
  def edit; end

  # post /join
  def create
    handler = Components::Users::ProfileHandler.new
    permitted = handler.class.permitted_parameters
    @entity = handler.register(params.expect(user: permitted))
    if @entity.id.present?
      session[:user_id] = @entity.id
      redirect_to me_path
    else
      @errors = handler.errors
      render :new, status: :bad_request
    end
  end

  # patch /me
  def update
    handler = Components::Users::ProfileHandler.new(user: @entity)
    permitted = handler.class.permitted_parameters
    if handler.update(params.expect(user: permitted))
      redirect_to me_path
    else
      @errors = handler.errors
      render :edit, status: :unprocessable_content
    end
  end

  private

  def set_entity
    @entity = current_user

    redirect_to login_path if @entity.nil?
  end
end
