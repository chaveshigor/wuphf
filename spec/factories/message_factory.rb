# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    title { 'MyString' }
    message { 'MyText' }
    telegram_sended { false }
    email_sended { false }
    contact { nil }
  end
end
