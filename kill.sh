#!/usr/bin/sh

kill $(pidof daemons.rb) || echo "no daemon running"
