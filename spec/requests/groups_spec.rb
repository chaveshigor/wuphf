# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Groups', type: :request do
  let!(:user) { create(:user) }
  let!(:contact1) { create(:contact, user: user) }
  let!(:contact2) { create(:contact, user: user, first_name: 'son', last_name: 'goku') }
  let!(:contact3) { create(:contact, user: user, first_name: 'Itachi', last_name: 'Uchiha') }
  let!(:group) { create(:group, user: user, contacts: [contact1, contact2]) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'list all groups' do
      get groups_path

      expect(response).to have_http_status(200)
      expect(assigns(:groups)).to eq([group])
    end
  end

  describe 'GET /show' do
    it 'show a single group' do
      get group_path(group)

      expect(response).to have_http_status(200)
      expect(assigns(:group)).to eq(group)
    end
  end

  describe 'POST /create' do
    it 'create a new empty group' do
      group_params = {
        group: {
          name: 'justice league',
          description: 'dc >>> marvel',
          contact_ids: []
        }
      }

      expect { post groups_path params: group_params }.to change { Group.count }.by(1)
    end

    it 'create a new not empty group' do
      group_params = {
        group: {
          name: 'justice league',
          description: 'dc >>> marvel',
          contact_ids: [contact1.id, contact2.id]
        }
      }

      expect { post groups_path params: group_params }.to change { Group.count }.by(1)
    end
  end

  describe 'DELETE /destroy' do
    it 'destroy a group' do
      expect { delete group_path(group), params: { id: group.id } }.to change { Group.count }.by(-1)
    end
  end

  describe 'PUT /update' do
    it 'change group name' do
      group_params = {
        group: {
          id: group.id,
          name: 'Akatsuke',
          new_contacts: [],
          contacts_to_remove: []
        }
      }

      put group_path(group), params: group_params

      expect(response).to have_http_status(302)
      expect(group.reload.name).to eq('Akatsuke')
      expect(response).to redirect_to(group_path(group))
    end

    it 'change group name and add contacts to group' do
      group_params = {
        group: {
          id: group.id,
          name: 'Akatsuke',
          new_contacts: [contact3.id],
          contacts_to_remove: []
        }
      }
      contacts_in_group = group.contacts.count

      put group_path(group), params: group_params

      expect(response).to have_http_status(302)
      expect(group.reload.name).to eq('Akatsuke')
      expect(group.reload.contacts.count).to eq(contacts_in_group + 1)
      expect(group.reload.contacts.find { |c| c.id == contact3.id }).to eq(contact3)
      expect(response).to redirect_to(group_path(group))
    end

    it 'change group name and remove contact from group' do
      group_params = {
        group: {
          id: group.id,
          name: 'Akatsuke',
          new_contacts: [],
          contacts_to_remove: [contact2.id]
        }
      }
      contacts_in_group = group.contacts.count
      put group_path(group), params: group_params

      expect(response).to have_http_status(302)
      expect(group.reload.name).to eq('Akatsuke')
      expect(group.reload.contacts.count).to eq(contacts_in_group - 1)
      expect(group.reload.contacts.find { |c| c.id == contact2.id }).to eq(nil)
      expect(response).to redirect_to(group_path(group))
    end
  end
end
