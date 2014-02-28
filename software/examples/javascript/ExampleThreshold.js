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
        // Get threshold callbacks with a debounce time of 1 seconds (1000ms)
        si.setDebouncePeriod(1000);
        // Configure threshold for "greater than 2000"
        si.setIntensityCallbackThreshold('>', 2000, 0);
    }
);

// Register intensity callback
si.on(Tinkerforge.BrickletSoundIntensity.CALLBACK_INTENSITY_REACHED,
    // Callback for intensity greater than 2000
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
