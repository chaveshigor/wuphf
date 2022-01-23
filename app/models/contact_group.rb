# frozen_string_literal: true

class ContactGroup < ApplicationRecord
  belongs_to :contact
  belongs_to :group
end
