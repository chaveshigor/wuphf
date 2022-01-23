# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Contacts', type: :request do
  before do
    @thing = Thing.new
  end
  describe 'GET /index' do
    it 'list all contacts' do
      get contacts_path

      puts response.status
    end
  end
end
