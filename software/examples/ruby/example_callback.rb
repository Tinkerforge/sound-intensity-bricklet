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

# Set Period for intensity callback to 1s (1000ms)
# Note: The intensity callback is only called every second if the 
#       intensity has changed since the last call!
si.set_intensity_callback_period 1000

# Register intensity callback (parameter has unit Lux/10)
si.register_callback(BrickletSoundIntensity::CALLBACK_INTENSITY) do |intensity|
  puts "Intensity: #{intensity}"
end

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
