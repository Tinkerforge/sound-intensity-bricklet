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

# Get threshold callbacks with a debounce time of 1 second (1000ms)
si.set_debounce_period 1000

# Register threshold reached callback for intensity greater than 2000
si.register_callback(BrickletSoundIntensity::CALLBACK_INTENSITY_REACHED) do |intensity|
  puts "Intensity: #{intensity}"
end

# Configure threshold for "greater than 2000"
si.set_intensity_callback_threshold '>', 2000, 0

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
