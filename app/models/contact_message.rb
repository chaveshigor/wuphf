# frozen_string_literal: true

class ContactMessage < ApplicationRecord
  belongs_to :contact
  belongs_to :message
end
