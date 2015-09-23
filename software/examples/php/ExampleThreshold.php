<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletSoundIntensity.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletSoundIntensity;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change to your UID

// Callback function for intensity reached callback
function cb_intensityReached($intensity)
{
    echo "Intensity: $intensity\n";
}

$ipcon = new IPConnection(); // Create IP connection
$si = new BrickletSoundIntensity(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get threshold callbacks with a debounce time of 1 second (1000ms)
$si->setDebouncePeriod(1000);

// Register intensity reached callback to function cb_intensityReached
$si->registerCallback(BrickletSoundIntensity::CALLBACK_INTENSITY_REACHED, 'cb_intensityReached');

// Configure threshold for intensity "greater than 2000"
$si->setIntensityCallbackThreshold('>', 2000, 0);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
