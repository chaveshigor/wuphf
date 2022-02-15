# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: %w[edit update show destroy]

  def index
    @contacts = User.find(current_user[:id]).contacts
  end

  def show; end

  def new
    @current_contact = Contact.new
  end

  def create
    @current_contact = Contact.new(contact_params)
    @current_contact[:user_id] = current_user[:id]

    if @current_contact.save
      redirect_to contact_path(@current_contact)
      ContactMailer.with(new_contact: @current_contact).notify_new_contact.deliver_later
    end
  end

  def update
    redirect_to contact_path(@current_contact) if @current_contact.update(contact_params)
  end

  def edit; end

  def destroy
    redirect_to contacts_path if Contact.destroy(@current_contact[:id])
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :telegram_profile, :phone_number, :gender)
  end

  def set_contact
    @current_contact = Contact.find(params[:id])
  end
end
