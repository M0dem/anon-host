#!/usr/bin/ruby

require "daemons"
require "em-websocket"

def popQueue(file)
	queue = ""
	File.open(file, "r+") do |f|	
		lines = f.read.split "\n"
		queue = lines.pop
		f.truncate(0)
		f.write lines.join("\n")
	end
	return queue
end

$pwd = Dir.pwd
$host = "m0dem.grepper.net"
$port = 6125
# files
$log = "./log"
$queue = "./queue"

nextQueue = popQueue($queue)
puts "next queue: #{nextQueue}"

#Signal.trap("HUP") { File.open("/tmp/log","w") do |f| f.write "Caught HUP!"; end; }
Daemons.daemonize
Dir.chdir $pwd
EventMachine::WebSocket.start(:host => $host, :port => $port) do |ws|
  ws.onopen    {
	  ws.send "Hello client!"
  }
  ws.onmessage do |msg| 
		File.open($log, "w") do |f|
	  	f.truncate(0)
  	  f.write(msg)
  	end
  end
  ws.onclose   {
	  puts "WebSocket closed"
  }
end
