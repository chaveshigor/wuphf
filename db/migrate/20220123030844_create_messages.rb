class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :status
      t.text :message_body
      t.references :user, null: false, foreign_key: true
      t.references :contact, null: false, foreign_key: true

      t.timestamps
    end
  end
end
