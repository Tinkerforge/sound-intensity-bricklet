#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletSoundIntensity;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => '7xwQ9g'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $si = Tinkerforge::BrickletSoundIntensity->new(&UID, $ipcon); # Create device object

# Callback function for intensity
sub cb_intensity
{
    my $intensity = shift;

    print "Intensity: $intensity\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Set Period for intensity callback to 1s (1000ms)
# Note: The intensity callback is only called every second if the 
#       intensity has changed since the last call!
$si->set_intensity_callback_period(1000);

# Register intensity callback to function cb_intensity
$si->register_callback($si->CALLBACK_INTENSITY, 'cb_intensity');

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

