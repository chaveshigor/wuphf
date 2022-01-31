# frozen_string_literal: true

class Message < ApplicationRecord
  has_many :contact_messages
  has_many :contacts, through: :contact_messages
end
