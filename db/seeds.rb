# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = { first_name: 'higor', last_name: 'chaves', email: 'higorchaves@gmail.com', password: '123456' }

def create_contacts(id)
  [{
    first_name: 'junior',
    last_name: 'pernambucano',
    email: 'junin@gmail.com',
    phone_number: '1234560',
    telegram_chat_id: nil,
    gender: 'Homem',
    user_id: id
  },

   {
     first_name: 'ana',
     last_name: 'bruna',
     email: 'anabruna28@gmail.com',
     phone_number: '789654',
     telegram_chat_id: nil,
     gender: 'Mulher',
     user_id: id
   },

   {
     first_name: 'fabio',
     last_name: 'otaku',
     email: 'fabin@gmail.com',
     phone_number: '741258',
     telegram_chat_id: nil,
     gender: 'Homem',
     user_id: id
   }]
end

def create_groups(id)
  [{ name: 'grupo do livro', description: 'pessoal do grupo do livro', user_id: id }]
end

user = User.create(user)
Contact.create(create_contacts(user.id))
Group.create(create_groups(user.id))
