#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletSoundIntensity;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $si = Tinkerforge::BrickletSoundIntensity->new(&UID, $ipcon); # Create device object

# Callback subroutine for intensity greater than 2000
sub cb_intensity_reached
{
    my ($intensity) = @_;

    print "Intensity: " . $intensity . "\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get threshold callbacks with a debounce time of 1 second (1000ms)
$si->set_debounce_period(1000);

# Register threshold reached callback to subroutine cb_intensity_reached
$si->register_callback($si->CALLBACK_INTENSITY_REACHED, 'cb_intensity_reached');

# Configure threshold for "greater than 2000"
$si->set_intensity_callback_threshold('>', 2000, 0);

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
