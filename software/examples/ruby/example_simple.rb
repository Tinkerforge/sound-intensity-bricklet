#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_sound_intensity'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change XYZ to the UID of your Sound Intensity Bricklet

ipcon = IPConnection.new # Create IP connection
si = BrickletSoundIntensity.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Get current intensity
intensity = si.get_intensity
puts "Intensity: #{intensity}"

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
