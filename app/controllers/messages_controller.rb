# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def show; end

  def new
    @new_message = Message.new
    @user_contacts = User.find(current_user.id).contacts.map { |con| [con.first_name, con.id] }
  end

  def create
    new_message = Message.new(message_params)
    new_message.save

    contact_params[:contact_id].each do |contact_id|
      ContactMessage.create!({ contact_id: contact_id, message_id: new_message.id }) if contact_id.present?
      # Throw send message event to queue in the future
    end
  end

  def send_message; end

  private

  def message_params
    params.require(:message).permit(:title, :message)
  end

  def contact_params
    params.require(:message).permit(contact_id: [])
  end
end
