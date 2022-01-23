class Contact < ApplicationRecord
  belongs_to :user
  has_many :messages
  has_many :contact_groups
  has_many :groups, through: :contact_groups
end
