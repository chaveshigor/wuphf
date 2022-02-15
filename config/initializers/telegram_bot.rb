# frozen_string_literal: true

require File.expand_path('app/api/telegram.rb')

def initialize_telegram_bot
  TelegramNotification.new.authorize
end

Thread.new { initialize_telegram_bot }
