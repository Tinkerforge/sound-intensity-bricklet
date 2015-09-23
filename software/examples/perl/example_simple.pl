#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletSoundIntensity;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $si = Tinkerforge::BrickletSoundIntensity->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current intensity
my $intensity = $si->get_intensity();
print "Intensity: $intensity\n";

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
