var IPConnection = require('Tinkerforge/IPConnection');
var BrickletSoundIntensity = require('Tinkerforge/BrickletSoundIntensity');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'iND';// Change to your UID

var ipcon = new IPConnection();// Create IP connection
var si = new BrickletSoundIntensity(UID, ipcon);// Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        console.log('Error: '+error);        
    }
);// Connect to brickd

// Don't use device before ipcon is connected
ipcon.on(IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        //Get current intensity
        si.getIntensity(
            function(intensity) {
                console.log('Intensity: '+intensity);
            },
            function(error) {
                console.log('Error: '+error);
            }
        );
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data',
    function(data) {
        ipcon.disconnect();
        process.exit(0);
    }
);

