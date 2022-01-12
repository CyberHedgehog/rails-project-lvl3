# frozen_string_literal: true

Rails.application.routes.draw do
  root 'bulletins#index'
  resources :bulletins do
    member do
      patch 'publish'
      patch 'archive'
      patch 'approve'
      patch 'reject'
    end
  end
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  namespace 'admin' do
    root 'bulletins#index'
    resources :bulletins, :categories, :users
  end
  get 'profile', to: 'profile#index'
end
