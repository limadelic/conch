require 'em-websocket'

module Client

  def self.run socket, cmd
    socket.send `#{cmd}`
  rescue
    socket.send ''
  end

  def self.listen_on socket
    socket.onmessage { |cmd| run socket, cmd }
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
