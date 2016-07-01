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
        // Set period for intensity callback to 0.05s (50ms)
        // Note: The intensity callback is only called every 0.05 seconds
        //       if the intensity has changed since the last call!
        si.setIntensityCallbackPeriod(50);
    }
);

// Register intensity callback
si.on(Tinkerforge.BrickletSoundIntensity.CALLBACK_INTENSITY,
    // Callback function for intensity callback
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
