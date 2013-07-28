require 'em-websocket'
require 'json'

module Client

  def self.run socket, cmd
    if respond_to? cmd['cmd']
      send cmd['cmd']
    else
      shell socket, cmd
    end
  end

  def self.exit
    exit! true
  end

  def self.shell socket, cmd
    Dir.chdir cmd['cwd'] do
      socket.send `#{cmd['cmd']}`
    end
  rescue
    socket.send ''
  end

  def self.listen_on socket
    socket.onopen { socket.send Dir.pwd }
    socket.onmessage { |cmd| run socket, JSON.parse(cmd) }
  end

  def self.start
    EM.run do
      EM::WebSocket.run(
        host: 'localhost',
        port: 8888
      ) { |socket| listen_on socket }
    end
  end

end
