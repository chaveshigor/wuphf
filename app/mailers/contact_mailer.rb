# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  def notify_new_contact
    @new_contact = params[:new_contact]
    @telegram_chat_url = 'algum link aqui'
    mail(to: @new_contact.email, subject: 'Você foi WUPHFADO')
  end

  def send_mail_message
    @message = params[:message]
    @contact = params[:contact]
    true if mail(to: @contact['email'], subject: 'Você foi WUPHFADO')
  end
end
