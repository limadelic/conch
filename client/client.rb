require 'em-websocket'

EM.run do
  EM::WebSocket.run host: 'localhost', port: 8888 do |ws|
    ws.onmessage { |msg| ws.send `#{msg}` }
  end
end