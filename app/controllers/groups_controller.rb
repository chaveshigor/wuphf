# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @new_group = Group.new
    @user_contacts = Contact.where({ user_id: current_user.id })
    @user_contacts = contact_sanitize(@user_contacts)
  end

  def create
    new_group = Group.new(group_params)
    new_group.user_id = current_user.id
    new_group.save

    AddUsersToGroup.call(new_group.id, group_members[:contact_ids])
  end

  def edit
    @group = Group.find(params[:id])
    contacts_in_group = @group.contacts
    user_contacts = User.find(current_user[:id]).contacts
    @contacts_not_in_group = user_contacts - contacts_in_group
    @contacts_not_in_group = contact_sanitize(@contacts_not_in_group)
  end

  def update
    group = Group.find(params[:id])
    group.name = group_edit[:name]
    group.contact_ids += group_edit[:new_contacts] if group_edit[:new_contacts].present?
    group.contact_ids -= group_edit[:contacts_to_remove].map(&:to_i) if group_edit[:contacts_to_remove].present?
    redirect_to group_path(group) if group.save
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end

  def group_members
    params.require(:group).permit(contact_ids: [])
  end

  def group_edit
    params.require(:group).permit(:name, :description, contacts_to_remove: [], new_contacts: [])
  end

  def contact_sanitize(contacts)
    contacts.map { |contact| ["#{contact.first_name} #{contact.last_name}", contact.id] }
  end
end
