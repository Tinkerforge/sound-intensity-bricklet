#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Sound Intensity Bricklet

# Get threshold callbacks with a debounce time of 1 second (1000ms)
tinkerforge call sound-intensity-bricklet $uid set-debounce-period 1000

# Handle incoming intensity reached callbacks
tinkerforge dispatch sound-intensity-bricklet $uid intensity-reached &

# Configure threshold for intensity "greater than 2000"
tinkerforge call sound-intensity-bricklet $uid set-intensity-callback-threshold threshold-option-greater 2000 0

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
