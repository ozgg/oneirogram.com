# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'My::Dreams', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/my/dreams/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/my/dreams/show'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get '/my/dreams/edit'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /update' do
    it 'returns http success' do
      get '/my/dreams/update'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/my/dreams/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
