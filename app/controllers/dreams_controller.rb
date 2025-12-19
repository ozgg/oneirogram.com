# frozen_string_literal: true

# Dreams
class DreamsController < ApplicationController
  before_action :require_authentication, except: %i[index show]
  before_action :set_entity, only: %i[show]

  # get /dreams
  def index
    @collection = Dream.page_for_user(current_user, current_page)
  end

  # get /dreams/:id
  def show; end

  # get /dreams/new
  def new
    @entity = Dream.new
    @places = SleepPlace.list_for_user(current_user)
  end

  # post /dreams
  def create
    handler = Components::Oneirogram::DreamHandler.new(user: current_user)
    permitted = handler.class.permitted_parameters
    @entity = handler.create(params.expect(dream: permitted))
    if @entity.id.present?
      redirect_to dream_path(@entity.id)
    else
      @errors = handler.errors
      render :new, status: :bad_request
    end
  end

  private

  def set_entity
    @entity = Dream.list_for_user(current_user).find(params[:id])
  end
end
