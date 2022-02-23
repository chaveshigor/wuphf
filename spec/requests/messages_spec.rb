# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  let!(:user) { create(:user) }
  let!(:contact1) { create(:contact, user: user) }
  let!(:contact2) { create(:contact, user: user, first_name: 'fred', last_name: 'thompson') }
  let!(:message) { create(:message, user: user, contacts: [contact1, contact2]) }
  let!(:group) { create(:group, user: user) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'list all messages' do
      get messages_path

      expect(response).to have_http_status(:success)
      expect(assigns(:all_messages)).to eq([message])
    end
  end

  describe 'GET /show' do
    it 'list message info' do
      get message_path(message)
      message_info = assigns(:message_info)

      expect(response).to have_http_status(:success)
      expect(message_info[:title]).to eq(message.attributes['title'])
      expect(message_info[:message]).to eq(message.attributes['message'])
      expect(message_info[:contacts_info]).to eq(message.contact_messages)
    end
  end

  describe 'POST /create' do
    it 'create a new message with a contact and without a group' do
      message_params = {
        message: {
          title: 'he man',
          message: 'HEYYEYAAEYAAAEYAEYAA',
          contact_id: [contact2.id],
          group: ''
        }
      }
      expect { post messages_path params: message_params }.to change { Message.count }.by(1)
    end

    it 'create a new message without contacts and with a group' do
      message_params = {
        message: {
          title: 'he man',
          message: 'HEYYEYAAEYAAAEYAEYAA',
          contact_id: [''],
          group: group.id
        }
      }
      expect { post messages_path params: message_params }.to change { Message.count }.by(1)
    end

    it 'create a new message with contacts and a group' do
      message_params = {
        message: {
          title: 'he man',
          message: 'HEYYEYAAEYAAAEYAEYAA',
          contact_id: [contact2.id, contact1.id],
          group: group.id
        }
      }
      expect { post messages_path params: message_params }.to change { Message.count }.by(1)
    end
  end
end
