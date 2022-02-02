# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @all_messages = Message.where({ user_id: current_user.id })
  end

  def show
    message = Message.find(params[:id])
    message_contacts = ContactMessage.where({ message_id: message.id })
    @message_info = { title: message.title, message: message.message, contacts: message_contacts.map do
      |contact_message|
      {
        full_name: "#{contact_message.contact.first_name} #{contact_message.contact.last_name}",
        telegram_sended: contact_message.telegram_sended,
        email_sended: contact_message.email_sended
      }
    end }

    puts @message_info[:contacts]
  end

  def new
    @new_message = Message.new
    @user_contacts = User.find(current_user.id).contacts.map { |con| [con.first_name, con.id] }
  end

  def create
    new_message = Message.new(message_params)
    new_message.user_id = current_user.id
    new_message.save

    contact_params[:contact_id].each do |contact_id|
      ContactMessage.create!({ contact_id: contact_id, message_id: new_message.id }) if contact_id.present?
      # Throw send message event to queue in the future
    end
  end

  private

  def message_params
    params.require(:message).permit(:title, :message)
  end

  def contact_params
    params.require(:message).permit(contact_id: [])
  end
end
