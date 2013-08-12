require 'json'
require 'open3'
require 'win32/process'
require 'sys/proctable'

module Cmd

  include Sys

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
    @in, @out, @wait_thr =
      Open3.popen2 "#{@cmd} 2>&1", {
        chdir: @cwd#,
        #new_pgroup: true
      }

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
  ensure
    @socket.send out
    close
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
    send ALIAS[@app] || @app
  end

  def is_child?(proc)
    [@wait_thr.pid, Process.pid].include? proc.ppid
  end

  def kill(proc)
    Process.detach proc.pid
    Process.kill 9, proc.pid
  rescue
    p 'crap'
  end

  def kill_children
    ProcTable.ps do |proc|
      if is_child? proc
        p proc.name
        Process.detach proc.pid
      end
    end
  end

  def exit
    #p 'exit'
    kill_children
    #Process.kill 'INT', Process.pid
    #EM.stop
    #Kernel.exit true
    abort
    #true
  end

  def ctrl_c
    kill @wait_thr
    close
  ensure
    return true
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