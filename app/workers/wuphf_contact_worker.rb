# frozen_string_literal: true

class WuphfContactWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(contacts, new_message)
    WuphfContact.call(contacts, new_message)
  end
end
