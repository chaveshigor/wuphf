# frozen_string_literal: true

Rails.application.routes.draw do
  resources :contacts
  resources :messages, only: %i[index show new create]

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
