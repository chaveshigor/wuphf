# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :title
      t.text :message
      t.boolean :telegram_sended
      t.boolean :email_sended
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
