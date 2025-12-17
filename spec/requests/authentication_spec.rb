# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
  describe 'GET /me' do
    it 'returns http success' do
      get '/authentication/me'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /login' do
    it 'returns http success' do
      get '/authentication/login'
      expect(response).to have_http_status(:success)
    end
  end
end
