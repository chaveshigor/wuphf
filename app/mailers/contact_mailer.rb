# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  def notify_new_contact
    @new_contact = params[:new_contact]
    @user_full_name = "#{@new_contact.user.first_name} #{@new_contact.user.last_name}"
    @telegram_chat_url = 'algum link aqui'
    @allow_wuphf = "https://#{ENV['MAIL_HOST']}/auth_contacts/#{@new_contact.id}"
    mail(to: @new_contact.email, subject: 'Você foi WUPHFADO')
  end

  def send_mail_message
    @message = params[:message]
    @contact = params[:contact]
    true if mail(to: @contact['email'], subject: "#{@contact['first_name']}, você foi WUPHFADO")
  end
end
