# frozen_string_literal: true

require 'telegram/bot'

# Class to store telegram variables and methods
class TelegramNotification
  def initialize
    @bot_token = ENV['TELEGRAM_TOKEN']
  end

  def send_message(contact, message)
    success = false
    message_text = "#{contact['first_name'].capitalize}, você foi WUPHFADO!\n\n\n#{message['title'].capitalize}\n#{message['message']}"

    Telegram::Bot::Client.run(@bot_token) do |bot|
      bot.api.send_message(chat_id: contact['telegram_chat_id'], text: message_text)
      success = true
    rescue Telegram::Bot::Exceptions::ResponseError
      return success
    end

    success
  end
end
