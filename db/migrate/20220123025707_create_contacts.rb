# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :telegram_chat_id
      t.string :gender
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
