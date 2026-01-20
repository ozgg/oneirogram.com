# frozen_string_literal: true

# Managing current user's dreams
module My
  class DreamsController < ApplicationController
    before_action :require_authentication
    before_action :set_handler
    before_action :set_entity, except: %i[index]

    # get /my/dreams
    def index
      @collector = Components::Oneirogram::DreamCollector.new(current_user)
      @collector.personal_page(current_page)
    end

    # get /my/dreams/:id
    def show
      @container = Components::Oneirogram::DreamContainer.new(current_user, @entity)
    end

    # get /my/dreams/:id/edit
    def edit
      @places = SleepPlace.list_for_user(current_user)
    end

    # patch /my/dreams/:id
    def update
      permitted = handler.class.permitted_parameters
      if handler.update(@entity, params.expect(dream: permitted))
        redirect_to my_dream_path(@entity.id)
      else
        render :edit, status: :bad_request
      end
    end

    # delete /my/dreams/:id
    def destroy
      @handler.destroy(@entity)

      redirect_to my_dreams_path
    end

    private

    def set_handler
      @handler = Components::Oneirogram::DreamHandler.new(user: current_user)
    end

    def set_entity
      @entity = Dream.owned_by(current_user).find(params[:id])
    end
  end
end
