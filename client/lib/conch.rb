require_relative 'client'

home = 'http://www.c0nch.com'

Client.start
`start chrome --app=#{home}`


