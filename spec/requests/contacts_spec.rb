# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Contacts', type: :request do
  let!(:contact) { create(:contact, user: user) }
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'list all contacts' do
      get '/contacts'

      expect(assigns(:contacts)).to eq([contact])
    end
  end
end
