# frozen_string_literal: true

module MessagesHelper
  def contacts_to_str(contacts)
    contacts_str = ''
    contacts.each do |c|
      contacts_str += ", #{c.first_name.capitalize} #{c.last_name.capitalize}"
    end
    contacts_str[2..]
  end
end
