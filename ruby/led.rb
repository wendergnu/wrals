# encoding: utf-8
#!/usr/bin/ruby

require 'em-websocket'
require 'rubygems'
require 'serialport'
require 'socket'
require 'time'

port_str = '/dev/ttyACM0'
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE
@sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)
print "Connecting...\n"
sleep 3
print "Connected in Arduino!\n"


myhost = "0.0.0.0"
myport = 8000

EM.run {
  puts "Waiting requires in port #{myport}..."

  EM::WebSocket.run(:host => myhost, :port => myport, :debug => false) do |ws|

    ws.onopen do |handshake|
      path = handshake.path
      param = handshake.query
      origin = handshake.origin      
    end
    
    ws.onmessage { |msg|
      puts msg
      @sp.write("#{msg}\n");
      sleep(0.2)
      dados = @sp.gets
      ws.send dados
    }
    
    ws.onclose {
      puts "Conexao encerrada pelo cliente"      
    }
    
    ws.onerror { |e|
      puts "Error: #{e.message}"
    }
  end
}


