# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :contact_groups
  has_many :contacts, through: :contact_groups
end
