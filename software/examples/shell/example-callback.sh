#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Sound Intensity Bricklet

# Handle incoming intensity callbacks
tinkerforge dispatch sound-intensity-bricklet $uid intensity &

# Set period for intensity callback to 0.05s (50ms)
# Note: The intensity callback is only called every 0.05 seconds
#       if the intensity has changed since the last call!
tinkerforge call sound-intensity-bricklet $uid set-intensity-callback-period 50

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
