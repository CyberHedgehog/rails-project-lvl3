# frozen_string_literal: true

Rails.application.routes.draw do
  post '/auth/:provider', to: 'auth#request', as: :auth_request
  get '/auth/:provider/callback', to: 'web/auth#callback', as: :callback_auth

  scope module: :web do
    resources :sessions, only: :destroy
    root 'bulletins#index'
    resources :bulletins do
      member do
        patch 'to_moderate'
        patch 'archive'
      end
    end
    namespace 'admin' do
      root 'bulletins#index'
      resources :bulletins do
        member do
          patch 'to_moderate'
          patch 'publish'
          patch 'archive'
          patch 'reject'
        end
      end
      resources :categories
      resources :users
    end
    get 'profile', to: 'profile#index'
  end
end
