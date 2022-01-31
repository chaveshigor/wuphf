# frozen_string_literal: true

class CreateContactMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_messages do |t|
      t.references :contact, null: false, foreign_key: true
      t.references :message, null: false, foreign_key: true
      t.boolean :telegram_sended, default: false
      t.boolean :email_sended, default: false

      t.timestamps
    end
  end
end
