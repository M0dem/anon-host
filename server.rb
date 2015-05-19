#!/usr/bin/ruby

require "daemons"
require "em-websocket"

$pwd = Dir.pwd
$host = "m0dem.grepper.net"
$port = 6125

#Signal.trap("HUP") { File.open("/tmp/log","w") do |f| f.write "Caught HUP!"; end; }
Daemons.daemonize
Dir.chdir $pwd
EventMachine::WebSocket.start(:host => $host, :port => $port) do |ws|
  ws.onopen    {
	  ws.send "Hello client!"
  }
  ws.onmessage do |msg| 
	File.open("log", "w") do |f|
	  f.truncate(0)
  	  f.write(msg)
  	end
  end
  ws.onclose   {
	  puts "WebSocket closed"
  }
end
