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
      get contacts_path

      expect(assigns(:contacts)).to eq([contact])
    end
  end

  describe 'GET /show' do
    it 'show a single contact' do
      get contact_path(contact)

      expect(assigns(:current_contact)).to eq(contact)
    end
  end

  describe 'POST /create' do
    subject(:contact_create) { post contacts_path params: contact_params }
    let(:contact_params) do
      {
        contact: {
          first_name: 'mario',
          last_name: 'luige',
          email: 'marioworld@mail.com',
          telegram_profile: 'its me',
          phone_number: '666',
          gender: 'Homem',
          user_id: 1
        }
      }
    end
    it 'create a new contact' do
      expect { contact_create }.to change { Contact.count }.by(1)
      expect(response).to redirect_to(contact_path(assigns(:current_contact)))
    end
  end

  describe 'DELETE /destroy' do
    subject(:contact_delete) { delete contact_path(contact) }
    it 'delete an user' do
      expect { contact_delete }.to change { Contact.count }.by(-1)
    end
  end
end
