# frozen_string_literal: true

# Class to store telegram variables and methods
class Telegram
  def initialize(profile, first_name, last_name)
    @profile = profile
    @first_name = first_name
    @last_name = last_name
    @full_name = "#{first_name} #{last_name}"
  end

  def send_message
    true
  end

  private

  attr_reader :profile, :first_name, :last_name, :full_name
end
