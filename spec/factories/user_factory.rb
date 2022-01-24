# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'Zezin' }
    last_name  { 'Forrozero' }
    password { 'quero cafe' }
    email { 'zezinforrozero@gmail.com' }
  end
end
