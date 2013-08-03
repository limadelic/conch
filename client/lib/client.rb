require 'em-websocket'
require 'json'

def start
  EM.run do
    EM::WebSocket.run(
      host: 'localhost',
      port: 8888
    ) { |socket| listen_on socket }
  end
end

def listen_on socket
  @socket = socket
  @socket.onopen { socket.send Dir.pwd }
  @socket.onmessage { |cmd| run cmd }
end

def run cmd
  parse cmd
  if respond_to? @cmd
    send @cmd
  else
    @socket.send shell
  end
end

def parse cmd
  cmd = JSON.parse cmd
  @cmd = cmd['cmd']
  @cwd = cmd['cwd']
end

def exit; exit! true end

def shell
  Dir.chdir(@cwd) { `#{@cmd}` }
rescue
  ''
end

start