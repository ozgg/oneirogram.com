# frozen_string_literal: true

module My
  class SleepPlacesController < ApplicationController
    before_action :require_authentication
    before_action :set_handler, only: %i[create update]
    before_action :set_entity, except: %i[create index new]

    # get /my/sleep_places
    def index
      @collection = SleepPlace.list_for_user(current_user)
    end

    # get /my/sleep_places/new
    def new
      @entity = SleepPlace.new
    end

    # get /my/sleep_places/:id/edit
    def edit; end

    # post /my/sleep_places
    def create
      permitted = @handler.class.permitted_parameters
      @entity = @handler.create(params.expect(sleep_place: permitted))
      if @entity.persisted?
        redirect_to my_sleep_places_path
      else
        render :new, status: :bad_request
      end
    end

    # patch /my/sleep_places/:id
    def update
      permitted = @handler.class.permitted_parameters
      if @handler.update(@entity, params.expect(sleep_place: permitted))
        redirect_to my_sleep_places_path
      else
        render :edit, status: :bad_request
      end
    end

    # delete /my/sleep_places/:id
    def destroy
      @entity.destroy
      redirect_to my_sleep_places_path
    end

    private

    def set_entity
      @entity = SleepPlace.owned_by(current_user).find(params[:id])
    end

    def set_handler
      @handler = Components::Oneirogram::SleepPlaceHandler.new(user: current_user)
    end
  end
end
