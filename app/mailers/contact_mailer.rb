class ContactMailer < ApplicationMailer
  default from: 'email@example.com'

  def notify_new_contact
    @new_contact = params[:new_contact]
    @telegram_chat_url = 'algum link aqui'
    mail(to: @user.email, subject: 'Você foi WUPHFADO')
  end
end
