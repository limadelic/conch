require_relative 'listener'

home = 'http://www.c0nch.com'

`start chrome --app=#{home}`
Listener.start

