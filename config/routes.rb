# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
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
