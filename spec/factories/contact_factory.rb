# frozen_string_literal: true

FactoryBot.define do
  factory :contact do
    first_name { 'joaozin' }
    last_name  { 'sertanejo' }
    phone_number { '12345678' }
    email { 'joaozinsertanejo@gmail.com' }
    telegram_profile { 'pokemonlover' }
    gender { 'Homem' }

    trait :with_user do
      before(:create) do |contact|
        contact.user = create(:user)
      end
    end
  end
end
