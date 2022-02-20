# frozen_string_literal: true

Rails.application.routes.draw do
  post 'auth_contacts/telegram', to: 'auth_contacts#auth_telegram'
  get 'auth_contacts', to: 'auth_contacts#auth_contact'

  resources :contacts
  resources :messages, only: %i[index show new create]
  resources :groups

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
