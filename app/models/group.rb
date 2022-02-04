# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :user
  has_many :contact_groups
  has_many :contacts, through: :contact_groups
end
