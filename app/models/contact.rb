# frozen_string_literal: true

class Contact < ApplicationRecord
  belongs_to :user
  has_many :contact_messages
  has_many :messages, through: :contact_messages
  has_many :contact_groups
  has_many :groups, through: :contact_groups
end
