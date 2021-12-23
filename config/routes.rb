# frozen_string_literal: true

Rails.application.routes.draw do
  resources :bulletins
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  root 'bulletins#index'
end
