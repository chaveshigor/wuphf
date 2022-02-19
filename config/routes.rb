# frozen_string_literal: true

Rails.application.routes.draw do
  post 'telegram_auths/create', to: 'telegram_auths#create'

  resources :contacts
  resources :messages, only: %i[index show new create]
  resources :groups

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
