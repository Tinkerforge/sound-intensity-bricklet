function octave_example_simple
    more off;
    
    HOST = "localhost";
    PORT = 4223;
    UID = "iQb"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    si = java_new("com.tinkerforge.BrickletSoundIntensity", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current intensity
    intensity = si.getIntensity();
    fprintf("Intensity: %g\n", intensity);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end
