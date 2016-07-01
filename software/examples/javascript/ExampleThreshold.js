var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'XYZ'; // Change XYZ to the UID of your Sound Intensity Bricklet

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var si = new Tinkerforge.BrickletSoundIntensity(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function (error) {
        console.log('Error: ' + error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function (connectReason) {
        // Get threshold callbacks with a debounce time of 1 second (1000ms)
        si.setDebouncePeriod(1000);

        // Configure threshold for intensity "greater than 2000"
        si.setIntensityCallbackThreshold('>', 2000, 0);
    }
);

// Register intensity reached callback
si.on(Tinkerforge.BrickletSoundIntensity.CALLBACK_INTENSITY_REACHED,
    // Callback function for intensity reached callback
    function (intensity) {
        console.log('Intensity: ' + intensity);
    }
);

console.log('Press key to exit');
process.stdin.on('data',
    function (data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
