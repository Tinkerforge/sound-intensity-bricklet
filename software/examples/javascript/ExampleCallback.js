var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'iND'; // Change to your UID

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var si = new Tinkerforge.BrickletSoundIntensity(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        console.log('Error: '+error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        // Set Period for intensity callback to 1s (1000ms)
        // Note: The intensity callback is only called every second if the
        // intensity has changed since the last call!
        si.setIntensityCallbackPeriod(1000);
    }
);

// Register intensity callback
si.on(Tinkerforge.BrickletSoundIntensity.CALLBACK_INTENSITY,
    // Callback function for intensity
    function(intensity) {
        console.log('Intensity: '+intensity);
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data',
    function(data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
