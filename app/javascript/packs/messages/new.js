const Rails = require("@rails/ujs")

let contact_ids = []
let check = document.getElementsByClassName('new-message-contacts-info')
let titleInput = document.getElementById('new-message-title')
let messageInput = document.getElementById('new-message-message')
let groupInput = document.getElementById('new-message-group')
let sendMessageBtt = document.getElementById('new-message-btt')


function get_contact_id(element) {
  const id = element.id.split('-')[4]

  return id
}

function add_contact_id(element) {
  const elementId = get_contact_id(element)
  element.checked ? contact_ids.push(elementId) : contact_ids.splice(contact_ids.indexOf(elementId), 1)
}

function blank_contact(element) {
  element.checked = false
}

function sendMessage(titleInput, messageInput, groupInput, contact_ids) {
  Rails.ajax({
    type: 'POST',
    url: '/messages',
    beforeSend(xhr, options) {
      xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
        options.data = JSON.stringify({
          'message': {
            title: titleInput.value,
            message: messageInput.value,
            contact_id: contact_ids,
            group_id: groupInput.value
          }
        })
        return true
    },
    success: '',
    error: ''
  })
}

Object.values(check).forEach(element => {
  blank_contact(element)
  element.addEventListener('change', () => {
    add_contact_id(element)
  })
});

sendMessageBtt.addEventListener('click', () => {
  titleInput.style.backgroundColor = 'transparent'
  messageInput.style.backgroundColor = 'transparent'

  if(!titleInput.value){
    titleInput.style.backgroundColor = 'rgba(255, 0, 0, .3)'
  }
  
  if(!messageInput.value){
    messageInput.style.backgroundColor = 'rgba(255, 0, 0, .3)'
  }
  
  if (titleInput.value && messageInput.value){
    sendMessage(titleInput, messageInput, groupInput, contact_ids)
  }
})
