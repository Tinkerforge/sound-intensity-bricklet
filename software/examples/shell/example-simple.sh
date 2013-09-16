#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=XYZ

# get current intensity
tinkerforge call sound-intensity-bricklet $uid get-intensity
