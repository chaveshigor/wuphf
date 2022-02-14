# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @all_messages = Message.where({ user_id: current_user.id })
  end

  def show
    message = Message.find(params[:id])
    message_contacts = message.contacts
    @message_info = { title: message.title, message: message.message, contacts: message_contacts.map do
      |contact_message|
      {
        full_name: "#{contact_message.contact.first_name} #{contact_message.contact.last_name}",
        telegram_sended: contact_message.telegram_sended,
        email_sended: contact_message.email_sended
      }
    end }
  end

  def new
    @new_message = Message.new
    @user_contacts = User.find(current_user.id).contacts.map { |con| [con.first_name, con.id] }
    @groups = User.find(current_user[:id]).groups.map { |group| [group.name, group.id] }
  end

  def create
    new_message = Message.new(message_params)
    new_message.user_id = current_user.id
    new_message.save
    contacts = []
    contacts += contact_params[:contact_id]
    contacts += Group.find(group_params[:group]).contact_ids
    new_message.contact_ids += contacts.uniq
    # Throw send message event to queue in the future
  end

  private

  def message_params
    params.require(:message).permit(:title, :message)
  end

  def contact_params
    params.require(:message).permit(:title, :message, contact_id: [])
  end

  def group_params
    params.require(:message).permit(:group)
  end
end
