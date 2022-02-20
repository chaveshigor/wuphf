class AuthContactsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def auth_telegram
    p 'parametros', params
    chat_id = params[:chat_id]
    email = params[:email]

    contact = Contact.find_by_email(email)

    return render json: { status: false, result: 'invalid chat id' } if chat_id.blank? || !number?(chat_id)
    return render json: { status: false, result: 'contact not founded' } if contact.nil?

    contact.telegram_chat_id = chat_id
    contact.save

    render json: { status: true, result: 'contact authorized' }
  end

  def auth_contact
    @contact = Contact.find(params[:contact_id])
    @contact.auth_to_wuphf = true
    @contact.save
  end

  def auth_telegram_params
    params.require(:telegram_auth).permit(:email, :chat_id)
  end

  def number?(str)
    true if Float(str) rescue false
  end
end
