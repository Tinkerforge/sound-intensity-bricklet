#!/usr/bin/perl

use strict;
use Tinkerforge::IPConnection;
use Tinkerforge::BrickletSoundIntensity;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change XYZ to the UID of your Sound Intensity Bricklet

# Callback subroutine for intensity callback
sub cb_intensity
{
    my ($intensity) = @_;

    print "Intensity: $intensity\n";
}

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $si = Tinkerforge::BrickletSoundIntensity->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Register intensity callback to subroutine cb_intensity
$si->register_callback($si->CALLBACK_INTENSITY, 'cb_intensity');

# Set period for intensity callback to 0.05s (50ms)
# Note: The intensity callback is only called every 0.05 seconds
#       if the intensity has changed since the last call!
$si->set_intensity_callback_period(50);

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
