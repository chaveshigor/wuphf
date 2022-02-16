class ContactMailer < ApplicationMailer
  def notify_new_contact
    @new_contact = params[:new_contact]
    @telegram_chat_url = 'algum link aqui'
    mail(to: @new_contact.email, subject: 'Você foi WUPHFADO')
  end
end
