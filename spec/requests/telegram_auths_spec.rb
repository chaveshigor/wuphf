# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TelegramAuths', type: :request do
  let!(:user) { create(:user) }
  let!(:contact) { create(:contact, user: user) }

  describe 'GET /create' do
    it 'auth user to receive telegram messages' do
      post '/auth_contacts/telegram', params: {
        chat_id: '1234',
        email: contact.email
      }

      body = eval response.body

      expect(response).to have_http_status(:success)
      expect(body[:status]).to eq(true)
      expect(body[:result]).to eq('contact authorized')
    end

    it 'should not auth user to receive telegram messages because chat_id is invalid' do
      post '/auth_contacts/telegram', params: {
        chat_id: '12342d',
        email: contact.email
      }

      body = eval response.body

      expect(response).to have_http_status(:success)
      expect(body[:status]).to eq(false)
      expect(body[:result]).to eq('invalid chat id')
    end

    it 'should not auth user to receive telegram messages because email is not registered' do
      post '/auth_contacts/telegram', params: {
        chat_id: '1234',
        email: 'rogerinho.do.inga@example.com'
      }

      body = eval response.body

      expect(response).to have_http_status(:success)
      expect(body[:status]).to eq(false)
      expect(body[:result]).to eq('contact not founded')
    end
  end
end
