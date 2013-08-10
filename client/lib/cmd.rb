require 'json'
require 'open3'

module Cmd

  COMMANDS = ['exit', 'cd']

  def run cmd
    parse cmd
    custom_cmd or
    @socket.send shell
  end

  def shell
    Dir.chdir(@cwd) do
      stdin, stdout, stderr = Open3.popen3 @cmd
      stdout.read + stderr.read
    end
  end

  def parse cmd
    cmd = JSON.parse cmd
    @cmd = cmd['cmd']
    @cwd = cmd['cwd']
    @args = @cmd.split(' ')
    @app = @args.shift
  end

  def custom_cmd
    return unless COMMANDS.include? @app
    send @app
  end

  def exit
    exit! true
  end

  def cd
    Dir.chdir(@cwd) do
      Dir.chdir(@args[0]) do
        @socket.send Dir.pwd
      end
    end
  rescue
    @socket.send @cwd
  ensure
    return false
  end

end