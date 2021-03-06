# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @all_messages = Message.where({ user_id: current_user.id }).order('created_at DESC')
  end

  def show
    message = Message.find(params[:id])
    message_contacts = ContactMessage.where({ message_id: message.id })
    @message_info = { title: message.title, message: message.message, contacts_info: message_contacts }
  end

  def new
    @new_message = Message.new
    @user_contacts = User.find(current_user.id).contacts.map { |con| ["#{con.first_name.capitalize} #{con.last_name.capitalize}", con.id, false] }
    @groups = User.find(current_user[:id]).groups.map { |group| [group.name, group.id] }
  end

  def create
    new_message = Message.new(message_params)
    new_message.user_id = current_user.id
    new_message.save

    new_message.contact_ids += capture_contacts
    WuphfContactWorker.perform_async(new_message.contacts.map(&:attributes), new_message.attributes)
    redirect_to message_path(new_message)
  end

  private

  def capture_contacts
    contacts = []
    contacts += contact_params[:contact_id] if contact_params[:contact_id].present?
    contacts += Group.find(group_params[:group]).contact_ids if group_params[:group].present?
    contacts.uniq
  end

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
