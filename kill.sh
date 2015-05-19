#!/usr/bin/sh

#kill $(pidof daemons.rb) || echo "no daemon running"

pid=$(pidof daemons.rb)
echo $pid >/tmp/log
kill $pid || echo "no daemon running"
