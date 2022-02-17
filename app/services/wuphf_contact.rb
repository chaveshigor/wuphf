class WuphfContact < ApplicationService
  def initialize(contacts, message)
    @contacts = contacts
    @message = message
  end

  def call
    wuphf_contacts
  end

  private
  attr_reader :contacts, :message

  def wuphf_contacts
    contacts.each do |contact|
      email_sended = ContactMailer.with(contact: contact, message: message).send_mail_message if contact.email
      telegram_sended = TelegramNotification.new.send_message(contact, message) if contact.telegram_chat_id

      message_info = ContactMessage.find_by(contact_id: contact.id, message_id: message.id)
      message_info.email_sended = email_sended
      message_info.telegram_sended = telegram_sended
      
      message_info.save
    end
  end
end
