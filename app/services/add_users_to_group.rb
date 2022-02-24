# frozen_string_literal: true

class AddUsersToGroup < ApplicationService
  def initialize(group_id, contact_ids)
    @group_id = group_id
    @contact_ids = contact_ids
  end

  def call
    add_users
  end

  private

  attr_reader :group_id, :contact_ids

  def add_users
    group = Group.find(group_id)
    group.contact_ids += contact_ids unless contact_ids.nil? || contact_ids.empty?
  end
end
