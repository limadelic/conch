require 'em-websocket'
require 'json'

def run socket, cmd
  if respond_to? cmd['cmd']
    send cmd['cmd']
  else
    shell socket, cmd
  end
end

def exit
  exit! true
end

def shell socket, cmd
  Dir.chdir cmd['cwd'] do
    socket.send `#{cmd['cmd']}`
  end
rescue
  socket.send ''
end

def listen_on socket
  socket.onopen { socket.send Dir.pwd }
  socket.onmessage { |cmd| run socket, JSON.parse(cmd) }
end

EM.run do
  EM::WebSocket.run(
    host: 'localhost',
    port: 8888
  ) { |socket| listen_on socket }
end
