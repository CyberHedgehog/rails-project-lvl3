# frozen_string_literal: true

Rails.application.routes.draw do
  root 'bulletins#index'
  resources :bulletins
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  namespace 'admin' do
    root 'home#index'
    resources :bulletins
  end
end
