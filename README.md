# WUPHF

If you are a true fan of the office, you certainly remember WUPHF.com, the revolutionary idea born in dunder mifflin. I know you're very eager to use it - that's what she said - but first, let's talk about what it does.

<img src="http://www.reactiongifs.com/r/wait-for-it.gif" alt="My Project GIF" width="500">

## Features

* You can sing up to use the services
* You can make create and remove contacts
* You can make crud operations with contact groups
* Your contact should allow to receive messages
* You can send a message to any number of contacts that you want. This message will be sent via email and telegram at the same time

## Techs

* Ruby on Rails: For all the CRUD stuff and show views
* Rails mailer to send emails
* Redis and Sidekiq: For the queue jobs
* Ajax
* A pretty telegram bot: For new contacts to authorize WUPHF to send messages through telegram. Check the <a href="https://github.com/chaveshigor/wuphf-telegrambot">bot code</a>
* <a href="https://cryptic-mesa-13758.herokuapp.com">Click here to use the app</a>