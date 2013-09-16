#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=XYZ

# set period for intensity callback to 1s (1000ms)
# note: the intensity callback is only called every second if the
#       intensity has changed since the last call!
tinkerforge call sound-intensity-bricklet $uid set-intensity-callback-period 1000

# handle incoming intensity callbacks
tinkerforge dispatch sound-intensity-bricklet $uid intensity
