class TelegramAuthsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    chat_id = auth_telegram_params[:chat_id]
    email = auth_telegram_params[:email]

    contact = Contact.find_by_email(email)

    render json: { status: false, result: 'invalid chat id' } if chat_id.blank? || !number?(chat_id)
    render json: { status: false, result: 'contact not founded' } if contact.nil?

    contact.telegram_chat_id = chat_id
    contact.save

    render json: { status: true, result: 'contact authorized' }
  end

  def auth_telegram_params
    params.require(:telegram_auth).permit(:email, :chat_id)
  end

  def number?(str)
    true if Float(str) rescue false
  end
end
