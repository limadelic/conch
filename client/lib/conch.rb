require 'em-websocket'

`start www.c0nch.com`

def run(socket, cmd)
  socket.send `#{cmd}`
rescue
  socket.send ''
end

def listen_on(socket)
  socket.onmessage {|cmd| run socket, cmd}
end

EM.run do
  EM::WebSocket.run(
    host: 'localhost',
    port: 8888
  ) { |socket| listen_on socket }
end