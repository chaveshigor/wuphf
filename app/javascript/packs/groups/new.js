const Rails = require("@rails/ujs")

let contact_ids = []

let checkboxList = document.getElementsByClassName('add-user-to-group')
let groupName = document.getElementById('create-group-name')
let groupDescription = document.getElementById('create-group-description')
let createGroupBtt = document.getElementById('create-group-btt')

function blankCheckbox(element) {
  element.checked = false
}

function get_contact_id(element) {
  const contacdId = element.id.split('-')[4]

  return contacdId
}

function add_contact_id(element) {
  const elementId = get_contact_id(element)
  element.checked ? contact_ids.push(elementId) : contact_ids.splice(contact_ids.indexOf(elementId), 1)
}

function sendMessage(groupName, groupDescription, contact_ids) {
  Rails.ajax({
    type: 'POST',
    url: '/groups',
    beforeSend(xhr, options) {
      xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
        options.data = JSON.stringify({
          'group': {
            name: groupName.value,
            description: groupDescription.value,
            contact_ids: contact_ids
          }
        })
        return true
    },
    success: '',
    error: ''
  })
}

Object.values(checkboxList).forEach(element => {
  blankCheckbox(element)
  element.addEventListener('change', () => {
    add_contact_id(element)
  })
})

createGroupBtt.addEventListener('click', () => {
  sendMessage(groupName, groupDescription, contact_ids)
})
