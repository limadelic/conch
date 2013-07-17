require 'em-websocket'

`start www.c0nch.com`

EM.run do
  EM::WebSocket.run host: 'localhost', port: 8888 do |ws|
    ws.onmessage { |msg| ws.send `#{msg}` }
  end
end