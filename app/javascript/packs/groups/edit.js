const Rails = require("@rails/ujs")

//:name, :description, new_contacts: [], contacts_to_remove: []
let new_contacts = []
let contacts_to_remove = []

let groupName = document.getElementById('create-group-name')
let groupDescription = document.getElementById('create-group-description')
let editGroupBtt = document.getElementById('edit-group-btt')

let contacts_to_add_checks = document.getElementsByClassName('contact-to-add')
let contacts_to_remove_checks = document.getElementsByClassName('contact-to-delete')

function getGroupId() {
  const urlItems = window.location.href.split('/')
  const contactId = urlItems[urlItems.length - 2]

  return contactId
}

function blankCheckbox(element) {
  element.checked = false
}

function getContactId(element) {
  const contactId = element.id.split('-')[3]

  return contactId
}

function add_contact_id(element, contact_ids) {
  const elementId = getContactId(element)
  element.checked ? contact_ids.push(elementId) : contact_ids.splice(contact_ids.indexOf(elementId), 1)

  return contact_ids
}

function editGroup(groupName, groupDescription, new_contacts, contacts_to_remove) {
  Rails.ajax({
    type: 'PUT',
    url: `/groups/${getGroupId()}`,
    beforeSend(xhr, options) {
      xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
        options.data = JSON.stringify({
          'group': {
            name: groupName.value,
            description: groupDescription.value,
            new_contacts: new_contacts,
            contacts_to_remove: contacts_to_remove
          }
        })
        return true
    },
    success: '',
    error: ''
  })
}

Object.values(contacts_to_add_checks).forEach(element => {
  blankCheckbox(element)
  element.addEventListener('change', () => {
    new_contacts = add_contact_id(element, new_contacts)
    console.log(new_contacts)
  })
})

Object.values(contacts_to_remove_checks).forEach(element => {
  blankCheckbox(element)
  element.addEventListener('change', () => {
    contacts_to_remove = add_contact_id(element, contacts_to_remove)
    console.log(contacts_to_remove)
  })
})

editGroupBtt.addEventListener('click', () => {
  editGroup(groupName, groupDescription, new_contacts, contacts_to_remove)
})