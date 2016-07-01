#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Sound Intensity Bricklet

# Get current intensity
tinkerforge call sound-intensity-bricklet $uid get-intensity
