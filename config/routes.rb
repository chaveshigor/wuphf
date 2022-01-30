# frozen_string_literal: true

Rails.application.routes.draw do
  get 'messages/index'
  get 'messages/show'
  get 'messages/send_message'
  resources :contacts

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
