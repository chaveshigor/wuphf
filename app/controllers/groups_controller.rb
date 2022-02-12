# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :authenticate_user!
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @new_group = Group.new
    @user_contacts = Contact.where({ user_id: current_user.id }).map { |contact| [contact.first_name, contact.id] }
  end

  def create
    new_group = Group.new(group_params)
    new_group.user_id = current_user.id
    new_group.save

    AddUsersToGroup.call(new_group.id, group_members[:contact_ids])
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end

  def group_members
    params.require(:group).permit(contact_ids: [])
  end
end
