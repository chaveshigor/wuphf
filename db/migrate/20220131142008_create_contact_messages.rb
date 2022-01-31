# frozen_string_literal: true

class CreateContactMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_messages do |t|
      t.belongs_to :contact
      t.belongs_to :message
      t.boolean :telegram_sended, default: false
      t.boolean :email_sended, default: false

      t.timestamps
    end
  end
end
