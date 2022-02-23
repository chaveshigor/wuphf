# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    first_name { 'joaozin' }
    last_name  { 'sertanejo' }
    phone_number { '12345678' }
    email { "#{first_name}.#{last_name}@example.com" }
    gender { 'Homem' }
  end
end
