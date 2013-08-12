require 'em-websocket'
require_relative 'cmd'

include Cmd

opts = {
  host: 'localhost',
  port: 8888
}

EM.run do
  EM::WebSocket.run opts do |socket|
    @socket = socket
    @socket.onopen { socket.send Dir.pwd }
    @socket.onmessage { |cmd| run cmd }
  end
end
