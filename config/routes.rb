# frozen_string_literal: true

Rails.application.routes.draw do
  post '/auth/:provider/callback', to: 'web/auth#callback', as: 'session'
  resource :session, only: :destroy
  
  scope module: :web do
    root 'bulletins#index'
    resources :bulletins do
      member do
        patch 'publish'
        patch 'archive'
        patch 'approve'
        patch 'reject'
      end
    end
    namespace 'admin' do
      root 'bulletins#index'
      resources :bulletins, :categories, :users
    end
    get 'profile', to: 'profile#index'
  end
end
