<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletSoundIntensity.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletSoundIntensity;

$host = 'localhost';
$port = 4223;
$uid = 'XYZ'; // Change to your UID

$ipcon = new IPConnection(); // Create IP connection
$si = new BrickletSoundIntensity($uid, $ipcon); // Create device object

$ipcon->connect($host, $port); // Connect to brickd
// Don't use device before ipcon is connected

// Get current intensity
$intensity = $si->getIntensity();

echo "Intensity: $intensity\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->disconnect();

?>
