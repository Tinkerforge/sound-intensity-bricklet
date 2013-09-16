<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletSoundIntensity.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletSoundIntensity;

$host = 'localhost';
$port = 4223;
$uid = 'XYZ'; // Change to your UID

// Callback for intensity greater than 2000
function cb_reached($intensity)
{
    echo "Intensity: " . $intensity . "\n";
}

$ipcon = new IPConnection(); // Create IP connection
$si = new BrickletSoundIntensity($uid, $ipcon); // Create device object

$ipcon->connect($host, $port); // Connect to brickd
// Don't use device before ipcon is connected

// Get threshold callbacks with a debounce time of 1 second (1000ms)
$si->setDebouncePeriod(1000);

// Register threshold reached callback to function cb_reached
$si->registerCallback(BrickletSoundIntensity::CALLBACK_INTENSITY_REACHED, 'cb_reached');

// Configure threshold for "greater than 2000"
$si->setIntensityCallbackThreshold('>', 2000, 0);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
