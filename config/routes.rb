# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root 'pages#home'

  controller :pages do
    get 'about'
  end

  resources :dreams, except: %i[edit update destroy]

  namespace :my do
    get '/' => 'index#index', as: :index
    resources :sleep_places, except: %i[show]
    resources :dreams, except: %i[new create]
  end

  controller :authentication do
    get 'me'
    get 'login'
    post 'login' => :authenticate
    delete 'logout'
  end

  controller :profiles do
    get 'join' => :new, as: :new_profile
    post 'join' => :create, as: nil
    get 'me/edit' => :edit, as: :edit_profile
    patch 'me' => :update, as: :update_profile
  end
end
