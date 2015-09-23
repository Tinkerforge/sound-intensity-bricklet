#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_sound_intensity'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change to your UID

ipcon = IPConnection.new # Create IP connection
si = BrickletSoundIntensity.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Register intensity callback
si.register_callback(BrickletSoundIntensity::CALLBACK_INTENSITY) do |intensity|
  puts "Intensity: #{intensity}"
end

# Set period for intensity callback to 0.05s (50ms)
# Note: The intensity callback is only called every 0.05 seconds
#       if the intensity has changed since the last call!
si.set_intensity_callback_period 50

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
