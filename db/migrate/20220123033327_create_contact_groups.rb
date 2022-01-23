class CreateContactGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_groups do |t|
      t.references :contact, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
