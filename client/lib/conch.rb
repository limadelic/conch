require 'em-websocket'

`start www.c0nch.com`

EM.run do
  EM::WebSocket.run host: 'localhost', port: 8888 do |ws|
    ws.onmessage do |msg|
      ws.send msg.length > 0 ? `#{msg}` : ''
    end
  end
end