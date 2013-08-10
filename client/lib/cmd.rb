require 'json'
require 'open3'

module Cmd

  COMMANDS = ['exit', 'cd', '^C']
  ALIAS = {
    '^C' => 'ctrl_c'
  }

  def run cmd
    parse cmd
    custom_cmd or
      shell
  end

  def shell
    cmd = "#{@cmd} 2>&1"
    @in, @out, @wait_thr = Open3.popen2 cmd, chdir: @cwd
    Thread.new { wait_for_cmd }
  end

  def close
    @out.close
    @in.close
  rescue
  end

  def wait_for_cmd
    out = ln = ''
    out += ln while ln = @out.gets
  rescue
  ensure
    close
    @socket.send out
  end

  def parse cmd
    cmd = JSON.parse cmd
    @cmd = cmd['cmd']
    @cwd = cmd['cwd']
    @args = @cmd.split(' ')
    @app = @args.shift
  end

  def custom_cmd
    p @app
    return unless COMMANDS.include? @app
    send ALIAS[@app] || @app
  end

  def exit
    exit! true
  end

  def ctrl_c
    p 'gonna ^C!!'
    Process.kill 'INT', @wait_thr[:pid]
    true
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