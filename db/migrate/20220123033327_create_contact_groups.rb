# frozen_string_literal: true

class CreateContactGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_groups do |t|
      t.belongs_to :contact
      t.belongs_to :group

      t.timestamps
    end
  end
end
