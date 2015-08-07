#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_sound_intensity import BrickletSoundIntensity

# Callback function for intensity callback
def cb_intensity(intensity):
    print('Intensity: ' + str(intensity))

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    si = BrickletSoundIntensity(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Set period for intensity callback to 1s (1000ms)
    # Note: The intensity callback is only called every second
    #       if the intensity has changed since the last call!
    si.set_intensity_callback_period(1000)

    # Register intensity callback to function cb_intensity
    si.register_callback(si.CALLBACK_INTENSITY, cb_intensity)

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
