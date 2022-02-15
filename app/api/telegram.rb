# frozen_string_literal: true

require 'telegram/bot'

# Class to store telegram variables and methods
class TelegramNotification
  def initialize
    @bot_token = ENV['TELEGRAM_TOKEN']
  end

  def send_message
    true
  end

  def save_chat_id(message)
    contact = Contact.find_by(email: message.text)
    return false if contact.nil?

    contact.telegram_profile = message.chat.id
    contact.save
  end

  def authorize
    Telegram::Bot::Client.run(@bot_token) do |bot|
      bot.listen do |message|
        bot.api.send_message(chat_id: message.chat.id, text: "Olá, #{message.from.first_name}. Parece que alguém quer te mandar uns Wuphfs.\nPara permitir, é só digitar seu email.") if message.text
        bot.api.send_message(chat_id: message.chat.id, text: 'Deu tudo certo :)') if save_chat_id(message)
      end
    end
  end
end
