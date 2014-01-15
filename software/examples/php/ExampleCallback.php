<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletSoundIntensity.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletSoundIntensity;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change to your UID

// Callback function for intensity
function cb_intensity($intensity)
{
    echo "Intensity: " . $intensity . "\n";
}

$ipcon = new IPConnection(); // Create IP connection
$si = new BrickletSoundIntensity(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Set Period for intensity callback to 1s (1000ms)
// Note: The intensity callback is only called every second if the
//       intensity has changed since the last call!
$si->setIntensityCallbackPeriod(1000);

// Register intensity callback to function cb_intensity
$si->registerCallback(BrickletSoundIntensity::CALLBACK_INTENSITY, 'cb_intensity');

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
